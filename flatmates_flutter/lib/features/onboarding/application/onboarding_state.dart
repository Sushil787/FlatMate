import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/theme_mode_provider.dart';

/// Whether the dishes story was seen; after that, sign-in opens directly.
final storySeenProvider = NotifierProvider<StorySeen, bool>(StorySeen.new);

class StorySeen extends Notifier<bool> {
  static const key = 'storySeen';

  @override
  bool build() => ref.watch(sharedPreferencesProvider)?.getBool(key) ?? false;

  void seen() {
    state = true;
    ref.read(sharedPreferencesProvider)?.setBool(key, true);
  }
}
