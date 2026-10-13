import 'dart:math';

import 'package:flatmates_client/flatmates_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/day.dart';
import '../data/chore_repository.dart';
import '../domain/chore_turns.dart';
import 'chores_controller.dart';

/// Every Chore's card on the Chores tab and the Turns on Home: your Turns
/// due today first, Done today last. Reloads with the Chores.
final choresNowProvider =
    AsyncNotifierProvider<ChoresNowController, List<ChoreNow>>(
      ChoresNowController.new,
    );

class ChoresNowController extends AsyncNotifier<List<ChoreNow>> {
  @override
  Future<List<ChoreNow>> build() async {
    final overview = await ref.watch(choresControllerProvider.future);
    final today = Day.fromLocal(DateTime.now());
    // Far enough ahead to see each Chore's next Turn.
    final days = overview.chores.fold(7, (m, c) => max(m, c.period.inDays));
    final turns = await ref
        .watch(choreRepositoryProvider)
        .turnsBetween(
          today.subtract(const Duration(days: 1)),
          today.add(Duration(days: days * 2)),
        );
    return _sorted([
      for (final c in overview.chores) ChoreNow.of(c, turns, today),
    ]);
  }

  static List<ChoreNow> _sorted(List<ChoreNow> cards) {
    int rank(ChoreNow c) => c.dueToday ? 0 : (c.doneToday ? 2 : 1);
    return cards..sort((a, b) {
      final r = rank(a).compareTo(rank(b));
      if (r != 0) return r;
      final da = a.turn?.day, db = b.turn?.day;
      if (da == null || db == null) return a.chore.name.compareTo(b.chore.name);
      return da.compareTo(db);
    });
  }

  /// Marks the Turn Done on screen straight away, then on the server; puts
  /// it back if the server refuses. The reload that follows brings the same
  /// state, so the screen moves once.
  Future<void> markDone(UuidValue turnId) => _change(
    turnId,
    (t) => t.copyWith(status: TurnStatus.done, doneAt: DateTime.now().toUtc()),
    () => ref.read(choresControllerProvider.notifier).markDone(turnId),
  );

  /// Takes a Done back, the same way.
  Future<void> undoDone(UuidValue turnId) => _change(
    turnId,
    (t) => t.copyWith(status: TurnStatus.active, doneAt: null),
    () => ref.read(choresControllerProvider.notifier).undoDone(turnId),
  );

  Future<void> _change(
    UuidValue turnId,
    Turn Function(Turn) change,
    Future<void> Function() send,
  ) async {
    final previous = state;
    final cards = state.value;
    if (cards != null) {
      state = AsyncData(
        _sorted([
          for (final c in cards)
            if (c.turn?.id == turnId) c.withTurn(change(c.turn!)) else c,
        ]),
      );
    }
    try {
      await send();
    } catch (_) {
      state = previous;
      rethrow;
    }
  }
}

/// Turns owed back under the Swap rule. Reloads with the Chores.
Future<List<SwapDebt>> _swapDebts(Ref ref) async {
  await ref.watch(choresControllerProvider.future);
  return ref.watch(choreRepositoryProvider).swapDebts();
}

final swapDebtsProvider = FutureProvider<List<SwapDebt>>(_swapDebts);

/// [choreId]'s Turns over the last 8 weeks and one Rotation ahead.
Future<ChoreHistory> _choreHistory(Ref ref, UuidValue choreId) async {
  final overview = await ref.watch(choresControllerProvider.future);
  final chore = overview.choreById(choreId);
  final today = Day.fromLocal(DateTime.now());
  final ahead = chore == null
      ? 0
      : chore.period.inDays * (chore.rotation.length + 1);
  final turns = await ref
      .watch(choreRepositoryProvider)
      .turnsBetween(
        today.subtract(const Duration(days: 56)),
        today.add(Duration(days: ahead)),
      );
  return ChoreHistory(turns.where((t) => t.choreId == choreId).toList(), today);
}

final choreHistoryProvider = FutureProvider.autoDispose
    .family<ChoreHistory, UuidValue>(_choreHistory);
