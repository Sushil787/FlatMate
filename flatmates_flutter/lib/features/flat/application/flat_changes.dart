import 'dart:async';

import 'package:flatmates_client/flatmates_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/flat_repository.dart';
import 'mate_directory.dart';

/// Whether the app can reach the server. Goes false when the live
/// connection drops and true once it's back.
final onlineProvider = NotifierProvider<Online, bool>(Online.new);

class Online extends Notifier<bool> {
  @override
  bool build() => true;

  void set(bool online) {
    if (state != online) state = online;
  }
}

/// Live change notices for the current Flat. Reconnects on its own; after
/// a reconnect it emits a `flat` change so everything is refetched.
Stream<FlatChange> _flatChanges(Ref ref) async* {
  final flatId = ref.watch(currentFlatIdProvider);
  if (flatId == null) return;
  final repo = ref.watch(flatRepositoryProvider);
  final online = ref.read(onlineProvider.notifier);

  var reconnecting = false;
  while (true) {
    try {
      if (reconnecting) {
        // The stream gives no sign it's connected; a call that succeeds does.
        await repo.mine();
        online.set(true);
        yield FlatChange(kind: FlatChangeKind.flat);
      }
      await for (final change in repo.changes()) {
        online.set(true);
        yield change;
      }
    } catch (_) {
      // Connection dropped; retry below.
      online.set(false);
    }
    reconnecting = true;
    await Future<void>.delayed(const Duration(seconds: 3));
  }
}

final flatChangesProvider = StreamProvider.autoDispose<FlatChange>(
  _flatChanges,
);
