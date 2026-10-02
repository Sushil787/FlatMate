import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_spacing.dart';

/// Flatmates' light and dark themes.
abstract final class AppTheme {
  static const _seed = Color(0xFF0F766E);

  static final light = _build(
    ColorScheme.fromSeed(seedColor: _seed).copyWith(
      primary: const Color(0xFF0F766E),
      onPrimary: Colors.white,
      primaryContainer: const Color(0xFFCCFBF1),
      onPrimaryContainer: const Color(0xFF042F2E),
      secondary: const Color(0xFFD97706),
      secondaryContainer: const Color(0xFFFEF3C7),
      onSecondaryContainer: const Color(0xFF451A03),
      tertiary: const Color(0xFF7C3AED),
      tertiaryContainer: const Color(0xFFEDE9FE),
      onTertiaryContainer: const Color(0xFF2E1065),
      surface: const Color(0xFFFAFAF7),
      onSurface: const Color(0xFF1C1F1E),
      onSurfaceVariant: const Color(0xFF5B625F),
      surfaceContainerLowest: Colors.white,
      surfaceContainerLow: const Color(0xFFF4F4EF),
      surfaceContainer: const Color(0xFFEFEFE9),
      surfaceContainerHigh: const Color(0xFFE9E9E2),
      surfaceContainerHighest: const Color(0xFFE2E2DA),
      outline: const Color(0xFFB9BFBB),
      outlineVariant: const Color(0xFFE2E4DE),
    ),
    AppColors.light,
  );

  static final dark = _build(
    ColorScheme.fromSeed(
      seedColor: _seed,
      brightness: Brightness.dark,
    ).copyWith(
      primary: const Color(0xFF2DD4BF),
      onPrimary: const Color(0xFF042F2E),
      primaryContainer: const Color(0xFF134E4A),
      onPrimaryContainer: const Color(0xFFCCFBF1),
      secondary: const Color(0xFFFBBF24),
      secondaryContainer: const Color(0xFF422006),
      onSecondaryContainer: const Color(0xFFFEF3C7),
      tertiary: const Color(0xFFA78BFA),
      tertiaryContainer: const Color(0xFF2E1065),
      onTertiaryContainer: const Color(0xFFEDE9FE),
      surface: const Color(0xFF0E1211),
      onSurface: const Color(0xFFE6EAE8),
      onSurfaceVariant: const Color(0xFF9AA4A0),
      surfaceContainerLowest: const Color(0xFF0A0D0C),
      surfaceContainerLow: const Color(0xFF141918),
      surfaceContainer: const Color(0xFF181E1D),
      surfaceContainerHigh: const Color(0xFF1F2625),
      surfaceContainerHighest: const Color(0xFF263030),
      outline: const Color(0xFF4A5551),
      outlineVariant: const Color(0xFF2A3230),
    ),
    AppColors.dark,
  );

  /// Bundled in assets/fonts (SIL Open Font License).
  static const fontFamily = 'PlusJakartaSans';

  static ThemeData _build(ColorScheme scheme, AppColors colors) {
    final base = ThemeData(
      colorScheme: scheme,
      useMaterial3: true,
      fontFamily: fontFamily,
    );
    final text = base.textTheme.copyWith(
      headlineMedium: const TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.5,
      ),
      headlineSmall: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.3,
      ),
      titleLarge: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
      titleMedium: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
      ),
      titleSmall: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.4,
      ),
      labelLarge: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w700,
      ),
    ).apply(
      fontFamily: fontFamily,
      bodyColor: scheme.onSurface,
      displayColor: scheme.onSurface,
    );

    final rounded = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(Radii.md),
    );

    return base.copyWith(
      textTheme: text,
      scaffoldBackgroundColor: scheme.surface,
      extensions: [colors],
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface,
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: text.titleLarge,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        margin: EdgeInsets.zero,
        color: scheme.surfaceContainerLowest,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Radii.lg),
          side: BorderSide(color: scheme.outlineVariant),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(0, 52),
          padding: const EdgeInsets.symmetric(horizontal: Insets.xl),
          shape: rounded,
          textStyle: text.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(0, 48),
          shape: rounded,
          side: BorderSide(color: scheme.outlineVariant),
          textStyle: text.labelLarge,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(textStyle: text.labelLarge),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: scheme.surfaceContainerLow,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: Insets.lg,
          vertical: Insets.lg,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Radii.md),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Radii.md),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Radii.md),
          borderSide: BorderSide(color: scheme.primary, width: 2),
        ),
      ),
      chipTheme: ChipThemeData(
        shape: const StadiumBorder(),
        side: BorderSide.none,
        backgroundColor: scheme.surfaceContainer,
        labelStyle: text.labelMedium,
      ),
      navigationBarTheme: NavigationBarThemeData(
        height: 72,
        backgroundColor: scheme.surfaceContainerLowest,
        indicatorColor: scheme.primaryContainer,
        surfaceTintColor: Colors.transparent,
        labelTextStyle: WidgetStatePropertyAll(text.labelSmall),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Radii.md + 2),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: rounded,
      ),
      dialogTheme: DialogThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Radii.lg),
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: scheme.surface,
        showDragHandle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(Radii.lg)),
        ),
      ),
      listTileTheme: ListTileThemeData(
        shape: rounded,
        contentPadding: const EdgeInsets.symmetric(horizontal: Insets.lg),
      ),
      dividerTheme: DividerThemeData(color: scheme.outlineVariant, space: 1),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: SegmentedButton.styleFrom(
          shape: rounded,
          side: BorderSide(color: scheme.outlineVariant),
        ),
      ),
    );
  }
}
