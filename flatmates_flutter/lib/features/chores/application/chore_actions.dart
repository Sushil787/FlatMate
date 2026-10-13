import 'package:flatmates_client/flatmates_client.dart';
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
    required List<UuidValue> rotation,
  }) => guard(
    () => _chores.create(
      name: name,
      period: period,
      startDay: startDay,
      rotation: rotation,
    ),
  );

  Future<bool> save({
    required UuidValue choreId,
    required String name,
    required Duration period,
    required List<UuidValue> rotation,
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
    .family<ArchiveChore, void, UuidValue>(ArchiveChore.new);

class ArchiveChore extends ActionNotifier {
  ArchiveChore(this.choreId);

  final UuidValue choreId;

  Future<bool> run() => guard(
    () => ref.read(choresControllerProvider.notifier).archive(choreId),
  );
}

/// Marking a Turn Done, by Turn id.
final markDoneProvider = AsyncNotifierProvider.autoDispose
    .family<MarkDone, void, UuidValue>(MarkDone.new);

class MarkDone extends ActionNotifier {
  MarkDone(this.turnId);

  final UuidValue turnId;

  Future<bool> run() => guard(
    () => ref.read(choresNowProvider.notifier).markDone(turnId),
  );
}

/// Taking back a Done, by Turn id.
final undoDoneProvider = AsyncNotifierProvider.autoDispose
    .family<UndoDone, void, UuidValue>(UndoDone.new);

class UndoDone extends ActionNotifier {
  UndoDone(this.turnId);

  final UuidValue turnId;

  Future<bool> run() => guard(
    () => ref.read(choresNowProvider.notifier).undoDone(turnId),
  );
}
