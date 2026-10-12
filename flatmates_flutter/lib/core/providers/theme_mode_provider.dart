import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Loaded and overridden in main. Null in tests, so nothing is stored.
final sharedPreferencesProvider = Provider<SharedPreferencesWithCache?>(
  (ref) => null,
);

/// System, light or dark, picked under Appearance in settings.
final themeModeControllerProvider =
    NotifierProvider<ThemeModeController, ThemeMode>(ThemeModeController.new);

class ThemeModeController extends Notifier<ThemeMode> {
  static const key = 'themeMode';

  @override
  ThemeMode build() {
    final saved = ref.watch(sharedPreferencesProvider)?.getString(key);
    return ThemeMode.values.asNameMap()[saved] ?? ThemeMode.system;
  }

  void set(ThemeMode mode) {
    state = mode;
    ref.read(sharedPreferencesProvider)?.setString(key, mode.name);
  }
}
