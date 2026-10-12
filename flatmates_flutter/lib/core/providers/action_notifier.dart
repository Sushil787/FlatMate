import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// One user action, such as Mark Done or Save Chore. Its state is loading
/// while the action runs, so its button can show a spinner and ignore taps,
/// and a second tap can never send it twice.
abstract class ActionNotifier extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  /// Runs [body] unless this action is already running. Returns false when
  /// it was (and so did nothing); otherwise true, or throws [body]'s error.
  @protected
  Future<bool> guard(Future<void> Function() body) async {
    if (state.isLoading) return false;
    state = const AsyncLoading();
    try {
      await body();
      if (ref.mounted) state = const AsyncData(null);
      return true;
    } catch (e, st) {
      if (ref.mounted) state = AsyncError(e, st);
      rethrow;
    }
  }
}
