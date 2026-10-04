import 'package:serverpod/serverpod.dart';

import '../flat_access.dart';
import '../generated/protocol.dart';
import '../rotation/turn_service.dart';

/// Chores, their Rotations and Turns.
class ChoreEndpoint extends Endpoint {
  // TODO(dev): login disabled, restore before shipping.
  // @override
  // bool get requireLogin => true;

  Future<List<Chore>> list(Session session) async {
    final (:me, :flat) = await requireMate(session);
    return Chore.db.find(
      session,
      where: (t) => t.flatId.equals(flat.id!) & t.archived.equals(false),
      orderBy: (t) => t.name,
    );
  }

  /// Every open Turn in the Flat: in progress, or waiting to start.
  Future<List<Turn>> activeTurns(Session session) async {
    final (:me, :flat) = await requireMate(session);
    return Turn.db.find(
      session,
      where: (t) =>
          t.flatId.equals(flat.id!) & t.status.equals(TurnStatus.active),
      orderBy: (t) => t.endsAt,
    );
  }

  /// Turns overlapping [from, to): real ones, plus projected future ones
  /// (which have no id).
  Future<List<Turn>> turnsBetween(
    Session session,
    DateTime from,
    DateTime to,
  ) async {
    final (:me, :flat) = await requireMate(session);
    final real = await Turn.db.find(
      session,
      where: (t) =>
          t.flatId.equals(flat.id!) & (t.startsAt < to) & (t.endsAt > from),
      orderBy: (t) => t.startsAt,
    );
    final projected = await TurnService.projectTurns(session, flat, to);
    return [
      ...real,
      ...projected.where(
        (t) => t.startsAt.isBefore(to) && t.endsAt.isAfter(from),
      ),
    ];
  }

  Future<Chore> create(
    Session session,
    String name,
    Duration period,
    DateTime startsAt,
    List<int> rotation,
  ) async {
    final (:me, :flat) = await requireAdmin(session);
    await _validate(session, flat, name, period, rotation);
    final chore = await Chore.db.insertRow(
      session,
      Chore(
        flatId: flat.id!,
        name: name.trim(),
        period: period,
        startsAt: startsAt.toUtc(),
        rotation: rotation,
        rotationIndex: -1,
        archived: false,
      ),
    );
    await TurnService.startChore(session, flat, chore);
    await broadcast(session, flat.id!, FlatChangeKind.chores);
    return chore;
  }

  /// Edits a Chore. The current Turn finishes as planned; changes apply
  /// from the next Turn.
  Future<Chore> update(
    Session session,
    int choreId,
    String name,
    Duration period,
    List<int> rotation,
  ) async {
    final (:me, :flat) = await requireAdmin(session);
    final chore = await _find(session, flat, choreId);
    await _validate(session, flat, name, period, rotation);

    if (!_sameList(chore.rotation, rotation)) {
      // Continue after whoever owns the current slot, if they're still in.
      final ownerSlot = chore.rotationIndex >= 0 &&
              chore.rotationIndex < chore.rotation.length
          ? chore.rotation[chore.rotationIndex]
          : null;
      chore.rotationIndex =
          ownerSlot == null ? -1 : rotation.indexOf(ownerSlot);
    }
    chore
      ..name = name.trim()
      ..period = period
      ..rotation = rotation;
    await Chore.db.updateRow(session, chore);
    await broadcast(session, flat.id!, FlatChangeKind.chores);
    return chore;
  }

  Future<void> archive(Session session, int choreId) async {
    final (:me, :flat) = await requireAdmin(session);
    final chore = await _find(session, flat, choreId);
    chore.archived = true;
    await Chore.db.updateRow(session, chore);
    await TurnService.stopChore(session, chore);
    await broadcast(session, flat.id!, FlatChangeKind.chores);
  }

  Future<Turn> markDone(Session session, int turnId) async {
    final (:me, :flat) = await requireMate(session);
    return TurnService.markDone(session, me, turnId);
  }

  Future<Chore> _find(Session session, Flat flat, int choreId) async {
    final chore = await Chore.db.findById(session, choreId);
    if (chore == null || chore.flatId != flat.id || chore.archived) {
      fail('Chore not found.');
    }
    return chore;
  }

  Future<void> _validate(
    Session session,
    Flat flat,
    String name,
    Duration period,
    List<int> rotation,
  ) async {
    if (name.trim().isEmpty) fail('Give the chore a name.');
    if (period < const Duration(hours: 1)) {
      fail('A turn must last at least an hour.');
    }
    if (rotation.isEmpty) fail('Pick at least one mate for the rotation.');
    final mateIds = (await activeMates(session, flat.id!))
        .map((m) => m.id!)
        .toSet();
    if (!rotation.every(mateIds.contains)) {
      fail('Everyone in the rotation must be in the flat.');
    }
  }
}

bool _sameList(List<int> a, List<int> b) =>
    a.length == b.length &&
    Iterable<int>.generate(a.length).every((i) => a[i] == b[i]);
