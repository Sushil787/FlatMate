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
    .family<CancelAway, void, int>(CancelAway.new);

class CancelAway extends ActionNotifier {
  CancelAway(this.awayId);

  final int awayId;

  Future<bool> run() =>
      guard(() => ref.read(awaysControllerProvider.notifier).cancel(awayId));
}
