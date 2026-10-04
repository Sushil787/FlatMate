import 'package:serverpod/serverpod.dart';

import '../flat_access.dart';
import '../generated/protocol.dart';
import '../rotation/turn_service.dart';

/// Marking yourself Away.
class AwayEndpoint extends Endpoint {
  // TODO(dev): login disabled, restore before shipping.
  // @override
  // bool get requireLogin => true;

  /// Away periods in the Flat that haven't ended yet.
  Future<List<Away>> list(Session session) async {
    final (:me, :flat) = await requireMate(session);
    final now = DateTime.now().toUtc();
    return Away.db.find(
      session,
      where: (t) => t.flatId.equals(flat.id!) & (t.endsAt > now),
      orderBy: (t) => t.startsAt,
    );
  }

  /// Marks the caller Away. Away can't start in the past.
  Future<Away> create(
    Session session,
    DateTime startsAt,
    DateTime endsAt,
  ) async {
    final (:me, :flat) = await requireMate(session);
    final now = DateTime.now().toUtc();
    startsAt = startsAt.toUtc();
    endsAt = endsAt.toUtc();
    // A minute of grace so "starting now" from the app isn't rejected.
    if (startsAt.isBefore(now.subtract(const Duration(minutes: 1)))) {
      fail('Away can\'t start in the past.');
    }
    if (!endsAt.isAfter(startsAt)) fail('Away must end after it starts.');

    final away = await Away.db.insertRow(
      session,
      Away(
        flatId: flat.id!,
        mateId: me.id!,
        startsAt: startsAt,
        endsAt: endsAt,
      ),
    );
    await TurnService.applyAway(session, flat, away);
    await broadcast(session, flat.id!, FlatChangeKind.away);
    return away;
  }

  /// Cancels one of the caller's Away periods before it starts. Covers
  /// already arranged for it stay as they are.
  Future<void> cancel(Session session, int awayId) async {
    final (:me, :flat) = await requireMate(session);
    final away = await Away.db.findById(session, awayId);
    if (away == null || away.mateId != me.id) fail('Away not found.');
    if (!away.startsAt.isAfter(DateTime.now().toUtc())) {
      fail('This away has already started.');
    }
    await Away.db.deleteRow(session, away);
    await broadcast(session, flat.id!, FlatChangeKind.away);
  }
}
