import 'dart:async';

import 'package:flatmates_client/flatmates_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/online_provider.dart';
import '../../../core/providers/read_cache.dart';
import '../data/flat_repository.dart';
import 'mate_directory.dart';

/// Live change notices for the current Flat. Reconnects on its own; after
/// a reconnect, or when a cold start showed saved data, it emits a `flat`
/// change so everything is refetched.
Stream<FlatChange> _flatChanges(Ref ref) async* {
  final flatId = ref.watch(currentFlatIdProvider);
  if (flatId == null) return;
  final repo = ref.watch(flatRepositoryProvider);
  final online = ref.read(onlineProvider.notifier);
  final cache = ref.read(readCacheProvider.notifier);

  var connected = false;
  var reconnecting = false;
  while (true) {
    try {
      if (!connected) {
        // The stream gives no sign it's connected; a call that succeeds does.
        await repo.probe();
        online.set(true);
        connected = true;
        if (cache.goLive() || reconnecting) {
          yield FlatChange(kind: FlatChangeKind.flat);
        }
      }
      await for (final change in repo.changes()) {
        online.set(true);
        yield change;
      }
    } catch (_) {
      // Connection dropped; retry below.
      online.set(false);
    }
    connected = false;
    reconnecting = true;
    await Future<void>.delayed(const Duration(seconds: 3));
  }
}

final flatChangesProvider = StreamProvider.autoDispose<FlatChange>(
  _flatChanges,
);
