import 'package:serverpod/serverpod.dart';

import '../day.dart';
import '../flat_access.dart';
import '../generated/protocol.dart';
import '../rotation/planner.dart';
import '../rotation/turn_service.dart';

/// Marking yourself Away.
class AwayEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// Away periods in the Flat that haven't ended yet.
  Future<List<Away>> list(Session session) async {
    final (:me, :flat) = await requireMate(session);
    final today = Day.today(flat.timezone);
    return Away.db.find(
      session,
      where: (t) => t.flatId.equals(flat.id!) & (t.lastDay >= today),
      orderBy: (t) => t.startDay,
    );
  }

  /// Marks the caller Away for the days [startDay]..[lastDay] (inclusive).
  /// Away can't start in the past.
  Future<Away> create(
    Session session,
    DateTime startDay,
    DateTime lastDay,
  ) async {
    final (:me, :flat) = await requireMate(session);
    final days = _days(flat, startDay, lastDay);
    final away = await Away.db.insertRow(
      session,
      Away(
        flatId: flat.id!,
        mateId: me.id!,
        startDay: days.startDay,
        lastDay: days.lastDay,
      ),
    );
    await TurnService.applyAway(session, flat, away);
    await broadcast(session, flat.id!, FlatChangeKind.away);
    return away;
  }

  /// What marking the caller Away for [startDay]..[lastDay] would do to
  /// their Turns. Saves nothing.
  Future<List<AwayEffect>> preview(
    Session session,
    DateTime startDay,
    DateTime lastDay,
  ) async {
    final (:me, :flat) = await requireMate(session);
    final days = _days(flat, startDay, lastDay);
    return TurnService.previewAway(
      session,
      flat,
      me,
      AwaySpan(me.id!, days.startDay, days.lastDay),
    );
  }

  /// Cancels one of the caller's Away periods before it starts. Covers
  /// already arranged for it stay as they are.
  Future<void> cancel(Session session, int awayId) async {
    final (:me, :flat) = await requireMate(session);
    final away = await Away.db.findById(session, awayId);
    if (away == null || away.mateId != me.id) fail('Away not found.');
    if (!away.startDay.isAfter(Day.today(flat.timezone))) {
      fail('This away has already started.');
    }
    await Away.db.deleteRow(session, away);
    await broadcast(session, flat.id!, FlatChangeKind.away);
  }
}

({DateTime startDay, DateTime lastDay}) _days(
  Flat flat,
  DateTime startDay,
  DateTime lastDay,
) {
  startDay = Day.from(startDay);
  lastDay = Day.from(lastDay);
  if (startDay.isBefore(Day.today(flat.timezone))) {
    fail('Away can\'t start in the past.');
  }
  if (lastDay.isBefore(startDay)) fail('Away must end after it starts.');
  return (startDay: startDay, lastDay: lastDay);
}
