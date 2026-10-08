import 'package:flatmates_client/flatmates_client.dart';
import 'package:intl/intl.dart';

import '../../../core/utils/day.dart';
import '../../../core/utils/formatters.dart';

/// "Every day", "Weekly", "Every 3 days", "Every 2 weeks".
String periodLabel(Duration period) => switch (period.inDays) {
  1 => 'Every day',
  7 => 'Weekly',
  _ => 'Every ${Fmt.period(period)}',
};

bool _sameDay(DateTime a, DateTime b) => a.isAtSameMomentAs(b);

/// Where a Chore stands today, for its card on the Chores tab. Days are
/// stored days (see day.dart).
class ChoreNow {
  ChoreNow._(this.chore, this.turn, this.next, this.missed, this.isToday);

  /// [turns] are around [today], real and projected, any Chore.
  factory ChoreNow.of(Chore chore, List<Turn> turns, DateTime today) {
    final mine = turns.where((t) => t.choreId == chore.id).toList()
      ..sort((a, b) => a.day.compareTo(b.day));
    final yesterday = today.subtract(const Duration(days: 1));
    final i = mine.indexWhere((t) => !t.lastDay.isBefore(today));
    final turn = i < 0 ? null : mine[i];
    return ChoreNow._(
      chore,
      turn,
      i < 0 || i + 1 >= mine.length ? null : mine[i + 1],
      mine
          .where(
            (t) =>
                t.status == TurnStatus.missed && _sameDay(t.lastDay, yesterday),
          )
          .firstOrNull,
      turn != null && !turn.day.isAfter(today),
    );
  }

  final Chore chore;

  /// This card with [turn] changed, e.g. marked Done before the server
  /// confirms it.
  ChoreNow withTurn(Turn turn) =>
      ChoreNow._(chore, turn, next, missed, isToday);

  /// Today's Turn, else the next one to start.
  final Turn? turn;

  /// The Turn after [turn].
  final Turn? next;

  /// Yesterday's Turn, when it ended without a Done.
  final Turn? missed;

  /// Whether [turn] is on today.
  final bool isToday;

  bool get doneToday => isToday && turn!.status == TurnStatus.done;

  /// A projected Turn (no id) hasn't started on the server yet, so it
  /// can't be marked Done: not due, the same as on Home.
  bool get dueToday =>
      isToday && turn!.status == TurnStatus.active && turn!.id != null;
}

/// A Chore's Turns over the last 8 weeks and one Rotation ahead.
class ChoreHistory {
  ChoreHistory(List<Turn> turns, this.today)
    : turns = [...turns]..sort((a, b) => a.day.compareTo(b.day));

  final List<Turn> turns;
  final DateTime today;

  /// Done and Missed Turns, newest first.
  List<Turn> get past => [
    for (final t in turns.reversed)
      if (t.status != TurnStatus.active) t,
  ];

  /// Today's Turn, else the next one to start.
  Turn? get current =>
      turns.where((t) => !t.lastDay.isBefore(today)).firstOrNull;

  bool isToday(Turn t) => !t.day.isAfter(today) && !t.lastDay.isBefore(today);

  int doneBy(int mateId) => turns
      .where((t) => t.mateId == mateId && t.status == TurnStatus.done)
      .length;

  /// The day [mateId]'s next Turn starts, today included.
  DateTime? nextDayOf(int mateId) => turns
      .where((t) => t.mateId == mateId && !t.lastDay.isBefore(today))
      .firstOrNull
      ?.day;
}

/// [mateId]'s Away covering [today], if any.
Away? awayOn(Iterable<Away>? aways, int mateId, DateTime today) => aways
    ?.where(
      (a) =>
          a.mateId == mateId &&
          !a.startDay.isAfter(today) &&
          !a.lastDay.isBefore(today),
    )
    .firstOrNull;

/// A stored day relative to today: "tomorrow", "Sun" within the week, else
/// "12 Oct".
String dayName(DateTime day) {
  final days = day.difference(Day.fromLocal(DateTime.now())).inDays;
  if (days == 1) return 'tomorrow';
  return DateFormat(days < 7 ? 'EEE' : 'd MMM').format(Day.local(day));
}
