import 'package:flatmates_client/flatmates_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../chores/application/chores_controller.dart';
import '../../flat/application/mate_directory.dart';
import '../data/away_repository.dart';

part 'aways_controller.g.dart';

/// Away periods in the Flat that haven't ended yet.
@Riverpod(keepAlive: true)
class AwaysController extends _$AwaysController {
  AwayRepository get _repo => ref.read(awayRepositoryProvider);

  @override
  Future<List<Away>> build() {
    ref.watch(currentFlatIdProvider);
    return ref.watch(awayRepositoryProvider).list();
  }

  Future<void> refresh() async => state = await AsyncValue.guard(_repo.list);

  /// Marks the user Away for the days [startDay]..[lastDay] (see day.dart).
  /// Their Turns may move, so Chores refresh too.
  Future<void> markAway(DateTime startDay, DateTime lastDay) async {
    await _repo.create(startDay, lastDay);
    await Future.wait([
      refresh(),
      ref.read(choresControllerProvider.notifier).refresh(),
    ]);
  }

  Future<void> cancel(int awayId) async {
    await _repo.cancel(awayId);
    await refresh();
  }
}
