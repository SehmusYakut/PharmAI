import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/config/app_config.dart';
import 'core/l10n/app_localizations.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'data/datasources/local/icd10_csv_parser.dart';
import 'data/datasources/local/local_database_service.dart';
import 'injection_container.dart';
import 'presentation/bloc/theme/theme_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  await _seedIcd10IfEmpty();
  runApp(
    BlocProvider(
      create: (_) => sl<ThemeCubit>(),
      child: const PharmAIApp(),
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
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return MaterialApp.router(
          title: AppConfig.appName,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: themeMode,
          routerConfig: appRouter,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
        );
      },
    );
  }
}
