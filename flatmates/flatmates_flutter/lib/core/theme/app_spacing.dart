import 'package:flutter/widgets.dart';

/// Spacing and radius scale used across the app.
abstract final class Insets {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;

  /// Horizontal padding of every screen.
  static const screen = EdgeInsets.symmetric(horizontal: lg);
}

abstract final class Radii {
  static const double sm = 10;
  static const double md = 16;
  static const double lg = 24;
  static const double pill = 999;
}
