import 'package:flatmates_client/flatmates_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../chores/application/chores_controller.dart';
import '../../flat/application/mate_directory.dart';
import '../data/away_repository.dart';

/// Away periods in the Flat that haven't ended yet.
final awaysControllerProvider =
    AsyncNotifierProvider<AwaysController, List<Away>>(AwaysController.new);

class AwaysController extends AsyncNotifier<List<Away>> {
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

/// What marking the user Away for [startDay]..[lastDay] (see day.dart)
/// would do to their Turns.
Future<List<AwayEffect>> _awayPreview(
  Ref ref,
  ({DateTime startDay, DateTime lastDay}) days,
) {
  ref.watch(currentFlatIdProvider);
  return ref.watch(awayRepositoryProvider).preview(days.startDay, days.lastDay);
}

final awayPreviewProvider = FutureProvider.autoDispose
    .family<List<AwayEffect>, ({DateTime startDay, DateTime lastDay})>(
      _awayPreview,
    );
