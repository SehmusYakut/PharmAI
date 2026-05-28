import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'core/auth/auth_state_notifier.dart';
import 'core/config/app_config.dart';
import 'core/constants/app_constants.dart';
import 'core/l10n/app_localizations.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'data/datasources/local/drug_json_parser.dart';
import 'data/datasources/local/icd10_csv_parser.dart';
import 'data/datasources/local/local_database_service.dart';
import 'data/datasources/local/seed_runner.dart';
import 'firebase_options.dart';
import 'injection_container.dart';
import 'core/security/security_service.dart';
import 'presentation/bloc/auth/auth_bloc.dart';
import 'presentation/bloc/bookmark/bookmark_bloc.dart';
import 'presentation/bloc/locale/locale_cubit.dart';
import 'presentation/bloc/onboarding/onboarding_cubit.dart';
import 'presentation/bloc/theme/theme_cubit.dart';

bool _seedFlowStarted = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await dotenv.load(fileName: '.env');
  } catch (_) {
    // .env is optional in debug; missing file should not crash startup.
  }

  // Only print and check GEMINI_API_KEY if dotenv is initialized
  if (dotenv.isInitialized) {
    debugPrint('Loaded GEMINI_API_KEY: \'${dotenv.env['GEMINI_API_KEY']}\'');
    AppConfig.ensureGeminiApiKeyLoaded();
  } else {
    debugPrint('dotenv not initialized; skipping GEMINI_API_KEY check.');
  }

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint('Firebase init error: $e');
  }

  try {
    await GoogleSignIn.instance.initialize(
      serverClientId:
          '521840446802-9h88fdbbebbv4s1mjme987p4mm4esrlh.apps.googleusercontent.com',
    );
  } catch (e) {
    debugPrint('GoogleSignIn init error: $e');
  }

  await initDependencies();
  
  // Non-blocking RASP check.
  unawaited(_performRaspCheck());

  // Non-blocking: locale code is a best-effort fire-and-forget at startup.
  FirebaseAuth.instance.setLanguageCode(sl<LocaleCubit>().state.languageCode);

  // Seed databases after the first frame in a single background queue.
  WidgetsBinding.instance.addPostFrameCallback((_) {
    unawaited(_runBackgroundSeedFlow());
  });

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<ThemeCubit>()),
        BlocProvider(create: (_) => sl<LocaleCubit>()),
        BlocProvider(create: (_) => sl<AuthBloc>()..add(const AuthStarted())),
        BlocProvider(create: (_) => sl<BookmarkBloc>()),
        BlocProvider(create: (_) => sl<OnboardingCubit>()..initialize()),
      ],
      child: BlocListener<LocaleCubit, Locale>(
        listener: (context, locale) {
          FirebaseAuth.instance.setLanguageCode(locale.languageCode);
        },
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthAuthenticated) {
              context.read<ThemeCubit>().loadFromProfile(state.profile);
              context.read<LocaleCubit>().loadFromProfile(state.profile);
            }
          },
          child: const PharmAIApp(),
        ),
      ),
    ),
  );
}

Future<void> _performRaspCheck() async {
  final security = sl<SecurityService>();
  final isCompromised = await security.isDeviceCompromised();
  if (isCompromised) {
    AppConfig.markDeviceAsCompromised();
  }
}

Future<void> _runBackgroundSeedFlow() async {
  if (_seedFlowStarted) return;
  _seedFlowStarted = true;

  // Let first paint + initial interactions complete before heavy I/O/CPU work.
  await Future<void>.delayed(const Duration(seconds: 2));

  try {
    final token = ServicesBinding.rootIsolateToken;
    if (token == null) {
      await _seedIcd10IfEmpty();
      await Future<void>.delayed(const Duration(milliseconds: 300));
      await _seedDrugsIfEmpty();
      await _verifySeededData();
      return;
    }

    final dir = await getApplicationDocumentsDirectory();
    await seedLocalDatabaseInBackground(
      SeedRequest(
        dbDirectory: dir.path,
        dbName: AppConfig.isarDbName,
        rootIsolateToken: token,
      ),
    );
  } catch (_) {
    // Best-effort seed flow: parsing errors should not crash app startup.
  } finally {
    await _verifySeededData();
  }
}

Future<void> _verifySeededData() async {
  final db = sl<LocalDatabaseService>();
  final icd10Count = await db.countIcd10();
  final drugCount = await db.countDrugs();
  if (icd10Count > 0 && drugCount > 0) return;

  final token = ServicesBinding.rootIsolateToken;
  if (token != null) {
    final dir = await getApplicationDocumentsDirectory();
    await seedLocalDatabaseInBackground(
      SeedRequest(
        dbDirectory: dir.path,
        dbName: AppConfig.isarDbName,
        rootIsolateToken: token,
      ),
    );
    return;
  }

  if (icd10Count == 0) {
    await _seedIcd10IfEmpty();
  }
  if (drugCount == 0) {
    await _seedDrugsIfEmpty();
  }
}

Future<void> _seedIcd10IfEmpty() async {
  final db = sl<LocalDatabaseService>();
  final count = await db.countIcd10();
  if (count > 0) return;
  final models = await Icd10CsvParser.parseFromAssets();
  await db.putAllIcd10(models);
}

Future<void> _seedDrugsIfEmpty() async {
  final db = sl<LocalDatabaseService>();
  final count = await db.countDrugs();
  if (count > 0) return;
  final models = await DrugJsonParser.parseFromAssets();
  await db.putAllDrugs(models);
}

class PharmAIApp extends StatelessWidget {
  const PharmAIApp({super.key});

  @override
  Widget build(BuildContext context) {
    String themeState = 'light';
    Locale locale = const Locale('tr');

    try {
      themeState = context.watch<ThemeCubit>().state;
    } catch (_) {
      themeState = 'light';
    }

    try {
      locale = context.watch<LocaleCubit>().state;
    } catch (_) {
      locale = const Locale('tr');
    }

    ThemeData themeData;
    if (themeState == 'dark') {
      themeData = AppTheme.dark;
    } else if (themeState == 'midnight') {
      themeData = AppTheme.midnight;
    } else {
      themeData = AppTheme.light;
    }

    return MaterialApp.router(
      title: AppConfig.appName,
      debugShowCheckedModeBanner: false,
      theme: themeData,
      locale: locale,
      routerConfig: buildRouterConfig(),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}

GoRouter buildRouterConfig() {
  if (sl.isRegistered<AuthStateNotifier>()) {
    return appRouter;
  }

  return GoRouter(
    initialLocation: AppConstants.routeHome,
    routes: [
      GoRoute(
        path: AppConstants.routeHome,
        builder: (context, state) =>
            const Scaffold(body: Center(child: SizedBox.shrink())),
      ),
    ],
  );
}
