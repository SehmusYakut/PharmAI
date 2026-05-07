import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'core/config/app_config.dart';
import 'core/l10n/app_localizations.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'data/datasources/local/icd10_csv_parser.dart';
import 'data/datasources/local/local_database_service.dart';
import 'firebase_options.dart';
import 'injection_container.dart';
import 'presentation/bloc/auth/auth_bloc.dart';
import 'presentation/bloc/locale/locale_cubit.dart';
import 'presentation/bloc/theme/theme_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await GoogleSignIn.instance.initialize(
    serverClientId:
        '521840446802-9h88fdbbebbv4s1mjme987p4mm4esrlh.apps.googleusercontent.com',
  );
  await initDependencies();
  await FirebaseAuth.instance.setLanguageCode(
    sl<LocaleCubit>().state.languageCode,
  );
  await _seedIcd10IfEmpty();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<ThemeCubit>()),
        BlocProvider(create: (_) => sl<LocaleCubit>()),
        BlocProvider(create: (_) => sl<AuthBloc>()..add(const AuthStarted())),
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

Future<void> _seedIcd10IfEmpty() async {
  final db = sl<LocalDatabaseService>();
  final count = await db.countIcd10();
  if (count > 0) return;
  final models = await Icd10CsvParser.parseFromAssets();
  await db.putAllIcd10(models);
}

class PharmAIApp extends StatelessWidget {
  const PharmAIApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeMode = context.watch<ThemeCubit>().state;
    final locale = context.watch<LocaleCubit>().state;
    return MaterialApp.router(
      title: AppConfig.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      locale: locale,
      routerConfig: appRouter,
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
