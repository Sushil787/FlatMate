import 'package:flatmates_client/flatmates_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/action_notifier.dart';
import 'aways_controller.dart';

/// Marking the signed-in Mate Away.
final markAwayProvider = AsyncNotifierProvider.autoDispose<MarkAway, void>(
  MarkAway.new,
);

class MarkAway extends ActionNotifier {
  Future<bool> run(DateTime startDay, DateTime lastDay) => guard(
    () =>
        ref.read(awaysControllerProvider.notifier).markAway(startDay, lastDay),
  );
}

/// Cancelling an Away, by Away id.
final cancelAwayProvider = AsyncNotifierProvider.autoDispose
    .family<CancelAway, void, UuidValue>(CancelAway.new);

class CancelAway extends ActionNotifier {
  CancelAway(this.awayId);

  final UuidValue awayId;

  Future<bool> run() =>
      guard(() => ref.read(awaysControllerProvider.notifier).cancel(awayId));
}
