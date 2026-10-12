import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/action_notifier.dart';
import 'chore_turns.dart';
import 'chores_controller.dart';

/// Creating a Chore or saving changes to one.
final saveChoreProvider = AsyncNotifierProvider.autoDispose<SaveChore, void>(
  SaveChore.new,
);

class SaveChore extends ActionNotifier {
  ChoresController get _chores => ref.read(choresControllerProvider.notifier);

  Future<bool> create({
    required String name,
    required Duration period,
    required DateTime startDay,
    required List<int> rotation,
  }) => guard(
    () => _chores.create(
      name: name,
      period: period,
      startDay: startDay,
      rotation: rotation,
    ),
  );

  Future<bool> save({
    required int choreId,
    required String name,
    required Duration period,
    required List<int> rotation,
  }) => guard(
    () => _chores.save(
      choreId: choreId,
      name: name,
      period: period,
      rotation: rotation,
    ),
  );
}

/// Deleting (archiving) a Chore, by Chore id.
final archiveChoreProvider = AsyncNotifierProvider.autoDispose
    .family<ArchiveChore, void, int>(ArchiveChore.new);

class ArchiveChore extends ActionNotifier {
  ArchiveChore(this.choreId);

  final int choreId;

  Future<bool> run() => guard(
    () => ref.read(choresControllerProvider.notifier).archive(choreId),
  );
}

/// Marking a Turn Done, by Turn id.
final markDoneProvider = AsyncNotifierProvider.autoDispose
    .family<MarkDone, void, int>(MarkDone.new);

class MarkDone extends ActionNotifier {
  MarkDone(this.turnId);

  final int turnId;

  Future<bool> run() => guard(
    () => ref.read(choresNowProvider.notifier).markDone(turnId),
  );
}

/// Taking back a Done, by Turn id.
final undoDoneProvider = AsyncNotifierProvider.autoDispose
    .family<UndoDone, void, int>(UndoDone.new);

class UndoDone extends ActionNotifier {
  UndoDone(this.turnId);

  final int turnId;

  Future<bool> run() => guard(
    () => ref.read(choresNowProvider.notifier).undoDone(turnId),
  );
}
