import 'package:flatmates_client/flatmates_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/day.dart';
import '../../away/domain/away_preview.dart';
import '../../chores/presentation/chore_editor_sheet.dart';
import '../../flat/application/mate_directory.dart';
import '../../flat/application/my_flat_controller.dart';

/// The pretend Flat onboarding runs on, in memory only: nothing here is
/// ever sent to the server.
class Practice {
  const Practice({
    required this.directory,
    this.chore,
    this.done = false,
    this.aways = const [],
  });

  /// The real Flat and Mates, with Mates from the dishes story added so
  /// there are at least three.
  final MateDirectory directory;

  /// The Admin's practice Chore, or the one "the Admin made" for a Mate.
  final Chore? chore;
  final bool done;
  final List<Away> aways;

  Practice copyWith({Chore? chore, bool? done, List<Away>? aways}) => Practice(
    directory: directory,
    chore: chore ?? this.chore,
    done: done ?? this.done,
    aways: aways ?? this.aways,
  );
}

final practiceProvider = NotifierProvider.autoDispose<PracticeRun, Practice>(
  PracticeRun.new,
);

class PracticeRun extends Notifier<Practice> {
  static final _choreId = UuidValue.fromString(
    '00000000-0000-7000-8000-00000000c001',
  );

  @override
  Practice build() {
    // Read once: finishing onboarding changes the Flat, and the practice
    // run must not start over under the user.
    final real = ref.read(myFlatControllerProvider).value!;
    final taken = {for (final m in real.mates) m.color};
    final freeColors = MateColor.values.where((c) => !taken.contains(c));
    final names = {for (final m in real.mates) m.displayName};
    final extra = [
      for (final (i, name) in ['Maya', 'Sam'].indexed)
        if (!names.contains(name))
          Mate(
            id: UuidValue.fromString('00000000-0000-7000-8000-00000000a00$i'),
            flatId: real.flat.id!,
            authUserId: UuidValue.fromString(
              '00000000-0000-4000-8000-00000000a00$i',
            ),
            displayName: name,
            joinedAt: DateTime.now(),
            color: freeColors.elementAtOrNull(i) ?? MateColor.values[i],
          ),
    ].take((3 - real.mates.length).clamp(0, 2));
    final directory = MateDirectory(
      real.copyWith(mates: [...real.mates, ...extra]),
    );
    final practice = Practice(directory: directory);
    if (directory.amAdmin) return practice;
    // A Mate who joined practises on a Chore "the Admin made", with them up
    // first.
    return practice.copyWith(
      chore: _chore(real.flat.id!, (
        name: 'Do the dishes',
        period: const Duration(days: 1),
        startDay: Day.fromLocal(DateTime.now()),
        rotation: [
          directory.me.id!,
          for (final m in directory.mates)
            if (!directory.isMe(m.id)) m.id!,
        ],
      )),
    );
  }

  Chore _chore(UuidValue flatId, ChoreDraft d) => Chore(
    id: _choreId,
    flatId: flatId,
    name: d.name,
    period: d.period,
    startDay: d.startDay,
    rotation: d.rotation,
    rotationIndex: 0,
    archived: false,
  );

  Future<bool> saveChore(ChoreDraft draft) async {
    state = state.copyWith(chore: _chore(state.directory.flat.id!, draft));
    return true;
  }

  void markDone() => state = state.copyWith(done: true);

  Future<bool> markAway(DateTime startDay, DateTime lastDay) async {
    final directory = state.directory;
    state = state.copyWith(
      aways: [
        ...state.aways,
        Away(
          flatId: directory.flat.id!,
          mateId: directory.me.id!,
          startDay: startDay,
          lastDay: lastDay,
        ),
      ],
    );
    return true;
  }

  /// What an Away on these stored days does to the practice Chore's Turns,
  /// by the real planner, as if its first Turn were open today.
  List<AwayEffect> awayEffects(DateTime startDay, DateTime lastDay) {
    final chore = state.chore;
    if (chore == null) return const [];
    final directory = state.directory;
    return previewAway(
      me: directory.me.id!,
      startDay: startDay,
      lastDay: lastDay,
      today: Day.fromLocal(DateTime.now()),
      chores: [chore],
      current: [
        Turn(
          flatId: chore.flatId,
          choreId: chore.id!,
          mateId: chore.rotation.first,
          day: chore.startDay,
          lastDay: chore.startDay,
          status: TurnStatus.active,
        ),
      ],
      awayRule: directory.flat.awayRule,
      mates: directory.mates,
      aways: state.aways,
      debts: const [],
    );
  }
}
