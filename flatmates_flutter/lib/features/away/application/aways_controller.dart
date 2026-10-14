import 'package:flatmates_client/flatmates_client.dart' hide AwayRepository;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/day.dart';
import '../../chores/application/chore_turns.dart';
import '../../chores/application/chores_controller.dart';
import '../../flat/application/mate_directory.dart';
import '../data/away_repository.dart';
import '../domain/away_preview.dart';

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

  Future<void> cancel(UuidValue awayId) async {
    await _repo.cancel(awayId);
    await refresh();
  }
}

/// What marking the signed-in Mate Away on the stored days [days] would do
/// to their Turns. Worked out on the phone from the Chores, Turns, Aways
/// and Swap debts it has, so it's instant and works offline.
Future<List<AwayEffect>> _awayPreview(
  Ref ref,
  ({DateTime startDay, DateTime lastDay}) days,
) async {
  final directory = ref.watch(mateDirectoryProvider);
  final (overview, aways, debts) = await (
    ref.watch(choresControllerProvider.future),
    ref.watch(awaysControllerProvider.future),
    ref.watch(swapDebtsProvider.future),
  ).wait;
  return previewAway(
    me: directory.me.id!,
    startDay: days.startDay,
    lastDay: days.lastDay,
    today: Day.fromLocal(DateTime.now()),
    chores: overview.chores,
    current: overview.currentTurns,
    awayRule: directory.flat.awayRule,
    mates: directory.mates,
    aways: aways,
    debts: debts,
  );
}

final awayPreviewProvider = FutureProvider.autoDispose
    .family<List<AwayEffect>, ({DateTime startDay, DateTime lastDay})>(
      _awayPreview,
    );
