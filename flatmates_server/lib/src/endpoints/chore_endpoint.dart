import 'package:serverpod/serverpod.dart';

import '../day.dart';
import '../flat_access.dart';
import '../generated/protocol.dart';
import '../notify/notifier.dart';
import '../rotation/turn_service.dart';

/// Chores, their Rotations and Turns.
class ChoreEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<List<Chore>> list(Session session) async {
    final (:me, :flat) = await requireMate(session);
    return Chore.db.find(
      session,
      where: (t) => t.flatId.equals(flat.id!) & t.archived.equals(false),
      orderBy: (t) => t.name,
    );
  }

  /// Each Chore's latest Turn: the open one, or today's once it's Done.
  /// The app projects the planned Turns that follow from these.
  Future<List<Turn>> currentTurns(Session session) async {
    final (:me, :flat) = await requireMate(session);
    await TurnService.catchUp(session, flat);
    // After catchUp only a Chore's latest Turn can still reach today.
    final turns = await Turn.db.find(
      session,
      where: (t) =>
          t.flatId.equals(flat.id!) & (t.lastDay >= Day.today(flat.timezone)),
      orderBy: (t) => t.day,
    );
    return {for (final t in turns) t.choreId: t}.values.toList();
  }

  /// Real Turns on the days [from]..[to] (inclusive). Planned ones are
  /// projected by the app with the shared planner.
  Future<List<Turn>> turnsBetween(
    Session session,
    DateTime from,
    DateTime to,
  ) async {
    final (:me, :flat) = await requireMate(session);
    await TurnService.catchUp(session, flat);
    from = Day.from(from);
    to = Day.from(to);
    return Turn.db.find(
      session,
      where: (t) =>
          t.flatId.equals(flat.id!) & (t.day <= to) & (t.lastDay >= from),
      orderBy: (t) => t.day,
    );
  }

  Future<Chore> create(
    Session session,
    String name,
    Duration period,
    DateTime startDay,
    List<UuidValue> rotation,
  ) async {
    final (:me, :flat) = await requireAdmin(session);
    await _validate(session, flat, name, period, rotation);
    startDay = Day.from(startDay);
    if (startDay.isBefore(Day.today(flat.timezone))) {
      fail('The first turn can\'t be in the past.');
    }
    final chore = await Chore.db.insertRow(
      session,
      Chore(
        flatId: flat.id!,
        name: name.trim(),
        period: period,
        startDay: startDay,
        rotation: rotation,
        rotationIndex: -1,
        archived: false,
      ),
    );
    await TurnService.startChore(session, flat, chore);
    await _notifyAdded(session, me, chore, rotation);
    await broadcast(session, flat.id!, FlatChangeKind.chores);
    return chore;
  }

  /// Edits a Chore. The current Turn finishes as planned; changes apply
  /// from the next Turn.
  Future<Chore> update(
    Session session,
    UuidValue choreId,
    String name,
    Duration period,
    List<UuidValue> rotation,
  ) async {
    final (:me, :flat) = await requireAdmin(session);
    final chore = await _find(session, flat, choreId);
    await _validate(session, flat, name, period, rotation);
    final added = rotation.toSet().difference(chore.rotation.toSet());

    if (chore.rotation.join(',') != rotation.join(',')) {
      // Continue after whoever owns the current slot, if they're still in.
      final ownerSlot =
          chore.rotationIndex >= 0 &&
              chore.rotationIndex < chore.rotation.length
          ? chore.rotation[chore.rotationIndex]
          : null;
      chore.rotationIndex = ownerSlot == null
          ? -1
          : rotation.indexOf(ownerSlot);
    }
    chore
      ..name = name.trim()
      ..period = period
      ..rotation = rotation;
    await Chore.db.updateRow(session, chore);
    await _notifyAdded(session, me, chore, added);
    await broadcast(session, flat.id!, FlatChangeKind.chores);
    return chore;
  }

  Future<void> archive(Session session, UuidValue choreId) async {
    final (:me, :flat) = await requireAdmin(session);
    final chore = await _find(session, flat, choreId);
    chore.archived = true;
    await Chore.db.updateRow(session, chore);
    await TurnService.stopChore(session, chore);
    await broadcast(session, flat.id!, FlatChangeKind.chores);
  }

  Future<Turn> markDone(Session session, UuidValue turnId) async {
    final (:me, :flat) = await requireMate(session);
    await TurnService.catchUp(session, flat);
    return TurnService.markDone(session, flat, me, turnId);
  }

  Future<Turn> undoDone(Session session, UuidValue turnId) async {
    final (:me, :flat) = await requireMate(session);
    await TurnService.catchUp(session, flat);
    return TurnService.undoDone(session, flat, me, turnId);
  }

  /// Turns owed back under the Swap rule, across the Flat's Chores.
  Future<List<SwapDebt>> swapDebts(Session session) async {
    final (:me, :flat) = await requireMate(session);
    final chores = await Chore.db.find(
      session,
      where: (t) => t.flatId.equals(flat.id!),
    );
    return SwapDebt.db.find(
      session,
      where: (t) => t.choreId.inSet(chores.map((c) => c.id!).toSet()),
      orderBy: (t) => t.createdAt,
    );
  }

  /// Tells Mates newly put into the Chore's Rotation, except the Admin.
  Future<void> _notifyAdded(
    Session session,
    Mate me,
    Chore chore,
    Iterable<UuidValue> mateIds,
  ) => Notifier.toMates(
    session,
    mateIds.where((id) => id != me.id),
    title: 'You\'ve been added to a Rotation',
    body: '${me.displayName} added you to ${chore.name}.',
    kind: NotifyKind.addedToRotation,
  );

  Future<Chore> _find(Session session, Flat flat, UuidValue choreId) async {
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
    List<UuidValue> rotation,
  ) async {
    if (name.trim().isEmpty) fail('Give the chore a name.');
    if (period < const Duration(days: 1) || period.inHours % 24 != 0) {
      fail('Turns must be at least a day apart.');
    }
    if (rotation.isEmpty) fail('Pick at least one mate for the rotation.');
    final mateIds = (await activeMates(
      session,
      flat.id!,
    )).map((m) => m.id!).toSet();
    if (!rotation.every(mateIds.contains)) {
      fail('Everyone in the rotation must be in the flat.');
    }
  }
}
