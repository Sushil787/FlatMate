import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../flat/application/mate_directory.dart';
import '../data/chore_repository.dart';
import '../domain/chores_overview.dart';

/// The Flat's Chores and their open Turns.
final choresControllerProvider =
    AsyncNotifierProvider<ChoresController, ChoresOverview>(
      ChoresController.new,
    );

class ChoresController extends AsyncNotifier<ChoresOverview> {
  ChoreRepository get _repo => ref.read(choreRepositoryProvider);

  @override
  Future<ChoresOverview> build() {
    ref.watch(currentFlatIdProvider);
    return _load(ref.watch(choreRepositoryProvider));
  }

  Future<ChoresOverview> _load(ChoreRepository repo) async {
    final (chores, turns) = await (repo.list(), repo.activeTurns()).wait;
    return ChoresOverview(chores: chores, activeTurns: turns);
  }

  Future<void> refresh() async {
    state = await AsyncValue.guard(() => _load(_repo));
  }

  Future<void> markDone(int turnId) async {
    await _repo.markDone(turnId);
    await refresh();
  }

  /// Takes back a Done while the Turn's day is still going.
  Future<void> undoDone(int turnId) async {
    await _repo.undoDone(turnId);
    await refresh();
  }

  Future<void> create({
    required String name,
    required Duration period,
    required DateTime startDay,
    required List<int> rotation,
  }) async {
    await _repo.create(
      name: name,
      period: period,
      startDay: startDay,
      rotation: rotation,
    );
    await refresh();
  }

  Future<void> save({
    required int choreId,
    required String name,
    required Duration period,
    required List<int> rotation,
  }) async {
    await _repo.update(
      choreId: choreId,
      name: name,
      period: period,
      rotation: rotation,
    );
    await refresh();
  }

  Future<void> archive(int choreId) async {
    await _repo.archive(choreId);
    await refresh();
  }
}
