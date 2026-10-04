import 'package:flutter/material.dart';

/// Brand colours that Material's [ColorScheme] has no slot for.
@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.success,
    required this.onSuccess,
    required this.successContainer,
    required this.warning,
    required this.warningContainer,
    required this.onWarningContainer,
    required this.event,
    required this.away,
    required this.heroGradient,
    required this.matePalette,
  });

  final Color success;
  final Color onSuccess;
  final Color successContainer;
  final Color warning;
  final Color warningContainer;
  final Color onWarningContainer;

  /// Calendar marker colours.
  final Color event;
  final Color away;

  /// Background of the "your turn" hero card and the sign-in screen.
  final Gradient heroGradient;

  /// Mates get a stable colour each, picked from this list.
  final List<Color> matePalette;

  Color mateColor(int? mateId) =>
      matePalette[(mateId ?? 0).abs() % matePalette.length];

  static const light = AppColors(
    success: Color(0xFF15803D),
    onSuccess: Colors.white,
    successContainer: Color(0xFFDCFCE7),
    warning: Color(0xFFB45309),
    warningContainer: Color(0xFFFEF3C7),
    onWarningContainer: Color(0xFF451A03),
    event: Color(0xFF7C3AED),
    away: Color(0xFFD97706),
    heroGradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF0F766E), Color(0xFF14B8A6)],
    ),
    matePalette: [
      Color(0xFF0EA5E9),
      Color(0xFFF97316),
      Color(0xFF8B5CF6),
      Color(0xFF10B981),
      Color(0xFFEC4899),
      Color(0xFFEAB308),
      Color(0xFF6366F1),
      Color(0xFFEF4444),
    ],
  );

  static const dark = AppColors(
    success: Color(0xFF4ADE80),
    onSuccess: Color(0xFF052E16),
    successContainer: Color(0xFF14532D),
    warning: Color(0xFFFBBF24),
    warningContainer: Color(0xFF422006),
    onWarningContainer: Color(0xFFFEF3C7),
    event: Color(0xFFA78BFA),
    away: Color(0xFFFBBF24),
    heroGradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF115E59), Color(0xFF0D9488)],
    ),
    matePalette: [
      Color(0xFF38BDF8),
      Color(0xFFFB923C),
      Color(0xFFA78BFA),
      Color(0xFF34D399),
      Color(0xFFF472B6),
      Color(0xFFFACC15),
      Color(0xFF818CF8),
      Color(0xFFF87171),
    ],
  );

  @override
  AppColors copyWith() => this;

  @override
  AppColors lerp(AppColors? other, double t) =>
      t < 0.5 ? this : (other ?? this);
}

extension AppColorsX on BuildContext {
  AppColors get colors => Theme.of(this).extension<AppColors>()!;
}
