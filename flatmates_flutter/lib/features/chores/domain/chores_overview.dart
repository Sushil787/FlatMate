import 'package:flatmates_client/flatmates_client.dart';

import '../../../core/utils/day.dart';

/// The Flat's Chores with their open Turns.
class ChoresOverview {
  ChoresOverview({required this.chores, required List<Turn> activeTurns})
    : _turnByChore = {for (final t in activeTurns) t.choreId: t};

  final List<Chore> chores;
  final Map<int, Turn> _turnByChore;

  Turn? turnFor(Chore chore) => _turnByChore[chore.id];

  Chore? choreById(int id) {
    for (final c in chores) {
      if (c.id == id) return c;
    }
    return null;
  }

  /// [mateId]'s open, not-yet-done Turns, soonest due first.
  List<(Chore, Turn)> openTurnsOf(int mateId) {
    final result = [
      for (final c in chores)
        if (_turnByChore[c.id] case final t?
            when t.mateId == mateId && t.status == TurnStatus.active)
          (c, t),
    ];
    result.sort((a, b) => a.$2.endsAt.compareTo(b.$2.endsAt));
    return result;
  }

  /// Every Chore except [mateId]'s open ones, soonest due first.
  List<Chore> othersFor(int mateId) {
    final mine = openTurnsOf(mateId).map((e) => e.$1.id).toSet();
    final rest = chores.where((c) => !mine.contains(c.id)).toList();
    rest.sort((a, b) {
      final ta = turnFor(a), tb = turnFor(b);
      if (ta == null || tb == null) return a.name.compareTo(b.name);
      return ta.endsAt.compareTo(tb.endsAt);
    });
    return rest;
  }
}

extension TurnX on Turn {
  bool get hasStarted => !startsAt.isAfter(DateTime.now());

  bool get isOpen => status == TurnStatus.active;

  /// How much of the Turn has passed, 0..1.
  double get elapsed {
    final total = endsAt.difference(startsAt).inSeconds;
    if (total <= 0) return 1;
    final gone = DateTime.now().difference(startsAt).inSeconds;
    return (gone / total).clamp(0, 1).toDouble();
  }
}
