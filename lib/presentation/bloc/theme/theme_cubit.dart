import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// App-wide theme mode controller.
///
/// Emits [ThemeMode] values consumed by [MaterialApp.themeMode].
/// Registered as a lazy singleton in the DI container and provided above
/// [MaterialApp] so every route can read or mutate the theme.
class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system);

  void setLight() => emit(ThemeMode.light);
  void setDark() => emit(ThemeMode.dark);
  void setSystem() => emit(ThemeMode.system);

  /// Toggles between light and dark, ignoring the system fallback.
  void toggle() =>
      emit(state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark);
}
