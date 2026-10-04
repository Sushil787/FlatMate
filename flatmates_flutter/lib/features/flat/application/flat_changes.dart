import 'dart:async';

import 'package:flatmates_client/flatmates_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/flat_repository.dart';
import 'mate_directory.dart';

part 'flat_changes.g.dart';

/// Live change notices for the current Flat. Reconnects on its own; after
/// a reconnect it emits a `flat` change so everything is refetched.
@riverpod
Stream<FlatChange> flatChanges(Ref ref) async* {
  final flatId = ref.watch(currentFlatIdProvider);
  if (flatId == null) return;
  final repo = ref.watch(flatRepositoryProvider);

  var reconnecting = false;
  while (true) {
    try {
      if (reconnecting) yield FlatChange(kind: FlatChangeKind.flat);
      await for (final change in repo.changes()) {
        yield change;
      }
    } catch (_) {
      // Connection dropped; retry below.
    }
    reconnecting = true;
    await Future<void>.delayed(const Duration(seconds: 3));
  }
}
