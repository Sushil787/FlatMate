import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_mode_provider.g.dart';

/// Light or dark. Follows the phone until the kitchen's bulb is tapped.
@Riverpod(keepAlive: true)
class ThemeModeController extends _$ThemeModeController {
  @override
  ThemeMode build() => ThemeMode.system;

  /// Switches away from what's showing now.
  void toggle(Brightness showing) =>
      state = showing == Brightness.dark ? ThemeMode.light : ThemeMode.dark;
}
