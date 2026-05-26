import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class AppTheme {
  static const Color _deepSeaBlue = Color(0xFF0B2D4D);
  static const Color _deepSeaBlueDark = Color(0xFF071827);
  static const Color _cyanTeal = Color(0xFF20C8D6);
  static const Color _teal = Color(0xFF14B8A6);
  static const Color _slate50 = Color(0xFFF8FAFC);
  static const Color _slate100 = Color(0xFFF1F5F9);
  static const Color _slate200 = Color(0xFFE2E8F0);
  static const Color _slate500 = Color(0xFF64748B);
  static const Color _slate800 = Color(0xFF1E293B);
  static const Color _slate900 = Color(0xFF0F172A);

  static ThemeData get light => _buildTheme(Brightness.light);

  static ThemeData get dark => _buildTheme(Brightness.dark);

  static ThemeData _buildTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final baseScheme = ColorScheme.fromSeed(
      seedColor: isDark ? _cyanTeal : _deepSeaBlue,
      brightness: brightness,
    );
    final scheme = baseScheme.copyWith(
      primary: isDark ? _cyanTeal : _deepSeaBlue,
      onPrimary: Colors.white,
      primaryContainer: isDark
          ? const Color(0xFF103B50)
          : const Color(0xFFD7F4F7),
      onPrimaryContainer: isDark
          ? const Color(0xFFA5F3FC)
          : const Color(0xFF08303F),
      secondary: isDark ? _teal : const Color(0xFF0F766E),
      onSecondary: Colors.white,
      secondaryContainer: isDark
          ? const Color(0xFF123B38)
          : const Color(0xFFCFFAF4),
      onSecondaryContainer: isDark
          ? const Color(0xFF9AE6B4)
          : const Color(0xFF0F3D3A),
      tertiary: isDark ? const Color(0xFF67E8F9) : const Color(0xFF0891B2),
      onTertiary: Colors.white,
      tertiaryContainer: isDark
          ? const Color(0xFF083344)
          : const Color(0xFFC7F9FF),
      onTertiaryContainer: isDark
          ? const Color(0xFFBFEFFF)
          : const Color(0xFF0B3652),
      surface: isDark ? _slate900 : Colors.white,
      onSurface: isDark ? const Color(0xFFE2E8F0) : _slate800,
      background: isDark ? _deepSeaBlueDark : _slate50,
      onBackground: isDark ? const Color(0xFFE2E8F0) : _slate800,
      surfaceDim: isDark ? const Color(0xFF0B1220) : _slate100,
      surfaceBright: isDark ? const Color(0xFF182033) : const Color(0xFFFBFDFF),
      surfaceContainerLowest: isDark ? const Color(0xFF0B1220) : Colors.white,
      surfaceContainerLow: isDark
          ? const Color(0xFF111827)
          : const Color(0xFFF8FAFC),
      surfaceContainer: isDark
          ? const Color(0xFF162033)
          : const Color(0xFFF1F5F9),
      surfaceContainerHigh: isDark
          ? const Color(0xFF1E293B)
          : const Color(0xFFE8EEF6),
      surfaceContainerHighest: isDark
          ? const Color(0xFF273449)
          : const Color(0xFFDCE7F2),
      onSurfaceVariant: isDark ? const Color(0xFF94A3B8) : _slate500,
      outline: isDark ? const Color(0xFF64748B) : const Color(0xFF94A3B8),
      outlineVariant: isDark ? const Color(0xFF334155) : _slate200,
      shadow: Colors.black,
      scrim: Colors.black,
      inverseSurface: isDark ? Colors.white : _slate800,
      onInverseSurface: isDark ? _slate900 : Colors.white,
      inversePrimary: isDark ? _cyanTeal : _deepSeaBlue,
      surfaceTint: isDark ? _cyanTeal : _deepSeaBlue,
    );

    final baseTextTheme =
        (isDark ? Typography.whiteMountainView : Typography.blackMountainView)
            .apply(fontFamily: 'Inter');

    final textTheme = baseTextTheme.copyWith(
      displayLarge: baseTextTheme.displayLarge?.copyWith(
        fontWeight: FontWeight.w800,
        letterSpacing: -0.8,
        height: 1.08,
      ),
      displayMedium: baseTextTheme.displayMedium?.copyWith(
        fontWeight: FontWeight.w800,
        letterSpacing: -0.6,
        height: 1.1,
      ),
      headlineLarge: baseTextTheme.headlineLarge?.copyWith(
        fontWeight: FontWeight.w800,
        letterSpacing: -0.5,
        height: 1.12,
      ),
      headlineMedium: baseTextTheme.headlineMedium?.copyWith(
        fontWeight: FontWeight.w700,
        letterSpacing: -0.3,
        height: 1.15,
      ),
      titleLarge: baseTextTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w700,
        height: 1.2,
      ),
      titleMedium: baseTextTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w700,
        height: 1.25,
      ),
      bodyLarge: baseTextTheme.bodyLarge?.copyWith(
        height: 1.5,
        letterSpacing: 0.1,
      ),
      bodyMedium: baseTextTheme.bodyMedium?.copyWith(
        height: 1.5,
        letterSpacing: 0.1,
      ),
      bodySmall: baseTextTheme.bodySmall?.copyWith(
        height: 1.45,
        letterSpacing: 0.05,
      ),
      labelLarge: baseTextTheme.labelLarge?.copyWith(
        fontWeight: FontWeight.w700,
        letterSpacing: 0.2,
      ),
      labelMedium: baseTextTheme.labelMedium?.copyWith(
        fontWeight: FontWeight.w700,
        letterSpacing: 0.4,
      ),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      fontFamily: 'Inter',
      scaffoldBackgroundColor: scheme.background,
      canvasColor: scheme.surface,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        foregroundColor: scheme.onSurface,
        elevation: 0,
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        color: scheme.surfaceContainerLowest.withValues(
          alpha: isDark ? 0.88 : 0.95,
        ),
        elevation: 0,
        shadowColor: scheme.shadow.withValues(alpha: 0.12),
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        margin: EdgeInsets.zero,
      ),
      dividerTheme: DividerThemeData(
        color: scheme.outlineVariant.withValues(alpha: 0.7),
        thickness: 1,
      ),
      iconTheme: IconThemeData(color: scheme.primary),
      listTileTheme: ListTileThemeData(
        iconColor: scheme.primary,
        textColor: scheme.onSurface,
        tileColor: Colors.transparent,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: scheme.surfaceContainerHighest.withValues(
          alpha: isDark ? 0.48 : 0.72,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: scheme.outlineVariant.withValues(alpha: 0.35),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: scheme.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: scheme.error, width: 1.2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: scheme.error, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
      ),
      expansionTileTheme: ExpansionTileThemeData(
        iconColor: scheme.primary,
        collapsedIconColor: scheme.outline,
        textColor: scheme.onSurface,
        collapsedTextColor: scheme.onSurface,
        childrenPadding: const EdgeInsets.only(bottom: 18),
        tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          textStyle: textTheme.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: scheme.primary,
          side: BorderSide(color: scheme.primary.withValues(alpha: 0.35)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          textStyle: textTheme.labelLarge,
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: scheme.surfaceContainerHighest.withValues(
          alpha: isDark ? 0.45 : 0.8,
        ),
        selectedColor: scheme.primaryContainer,
        secondarySelectedColor: scheme.secondaryContainer,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        labelStyle: textTheme.labelMedium?.copyWith(color: scheme.onSurface),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
        side: BorderSide(color: scheme.outlineVariant.withValues(alpha: 0.4)),
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: <TargetPlatform, PageTransitionsBuilder>{
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.macOS: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
        },
      ),
    );
  }
}
