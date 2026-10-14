import 'dart:math';

import 'package:flatmates_shared/flatmates_shared.dart';
import 'package:serverpod/serverpod.dart';

import '../day.dart';
import '../flat_access.dart';
import '../generated/protocol.dart';
import '../notify/digests.dart';
import '../notify/notifier.dart';
import '../rotation/turn_service.dart';

/// Creating, joining and running a Flat.
class FlatEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// The signed-in user's Flat, or null when they haven't joined one.
  Future<MyFlat?> mine(Session session) async {
    final me = await findCurrentMate(session);
    if (me == null) return null;
    return _myFlat(session, me);
  }

  /// Creates a Flat with the caller as its Admin.
  Future<MyFlat> create(
    Session session,
    String name,
    String displayName,
    String timezone,
  ) async {
    if (await findCurrentMate(session) != null) {
      fail('Leave your current flat first.');
    }
    name = _required(name, 'Flat name');
    if (!Day.isKnown(timezone)) fail('Unknown timezone: $timezone.');
    displayName = _required(displayName, 'Your name');
    final now = DateTime.now().toUtc();
    final inviteCode = await _newInviteCode(session);

    final me = await session.db.transaction((tx) async {
      final flat = await Flat.db.insertRow(
        session,
        Flat(
          name: name,
          timezone: timezone,
          inviteCode: inviteCode,
          inviteExpiresAt: _inviteExpiry(),
          awayRule: AwayRule.swap,
        ),
        transaction: tx,
      );
      final me = await Mate.db.insertRow(
        session,
        Mate(
          flatId: flat.id!,
          authUserId: currentUserId(session),
          displayName: displayName,
          joinedAt: now,
          color: MateColor.values.first,
        ),
        transaction: tx,
      );
      flat.adminMateId = me.id;
      await Flat.db.updateRow(session, flat, transaction: tx);
      return me;
    });
    return _myFlat(session, me);
  }

  /// Joins the Flat the Invite code belongs to, as a Mate.
  Future<MyFlat> join(
    Session session,
    String inviteCode,
    String displayName,
  ) async {
    if (await findCurrentMate(session) != null) {
      fail('Leave your current flat first.');
    }
    displayName = _required(displayName, 'Your name');
    final flat = await Flat.db.findFirstRow(
      session,
      where: (t) => t.inviteCode.equals(inviteCode.trim().toUpperCase()),
    );
    if (flat == null) fail('That invite code doesn\'t match any flat.');
    if (!flat.inviteExpiresAt.isAfter(DateTime.now().toUtc())) {
      fail(
        'That Invite code has expired. Ask your Flat\'s Admin for a new one.',
      );
    }

    final me = await Mate.db.insertRow(
      session,
      Mate(
        flatId: flat.id!,
        authUserId: currentUserId(session),
        displayName: displayName,
        joinedAt: DateTime.now().toUtc(),
        color: await _freeColor(session, flat.id!),
        welcomed: false,
      ),
    );
    final joined = joinedPush(displayName, flat.name);
    await Notifier.toFlat(
      session,
      flat.id!,
      title: joined.title,
      body: joined.body,
      exceptMateId: me.id,
    );
    await broadcast(session, flat.id!, FlatChangeKind.flat);
    return _myFlat(session, me);
  }

  /// Replaces the Invite code; the old one stops working.
  Future<String> regenerateInvite(Session session) async {
    final (:me, :flat) = await requireAdmin(session);
    flat
      ..inviteCode = await _newInviteCode(session)
      ..inviteExpiresAt = _inviteExpiry();
    await Flat.db.updateRow(session, flat);
    await broadcast(session, flat.id!, FlatChangeKind.flat);
    return flat.inviteCode;
  }

  Future<Flat> rename(Session session, String name) async {
    final (:me, :flat) = await requireAdmin(session);
    flat.name = _required(name, 'Flat name');
    await Flat.db.updateRow(session, flat);
    await broadcast(session, flat.id!, FlatChangeKind.flat);
    return flat;
  }

  Future<Mate> setMyName(Session session, String displayName) async {
    final (:me, :flat) = await requireMate(session);
    me.displayName = _required(displayName, 'Your name');
    await Mate.db.updateRow(session, me);
    await broadcast(session, flat.id!, FlatChangeKind.flat);
    return me;
  }

  Future<Mate> setMyColor(Session session, MateColor color) async {
    final (:me, :flat) = await requireMate(session);
    final mates = await activeMates(session, flat.id!);
    if (mates.any((m) => m.id != me.id && m.color == color)) {
      fail('That colour is taken by another Mate.');
    }
    me.color = color;
    await Mate.db.updateRow(session, me);
    await broadcast(session, flat.id!, FlatChangeKind.flat);
    return me;
  }

  /// Sets which push notifications the caller gets. [matesNotDone] is
  /// optional because older apps don't send it.
  Future<Mate> setNotifications(
    Session session, {
    required bool turnStarts,
    required bool reminder,
    bool? matesNotDone,
    required bool notice,
    required bool addedToRotation,
    bool? nightSummary,
  }) async {
    final (:me, :flat) = await requireMate(session);
    me
      ..notifyTurnStarts = turnStarts
      ..notifyReminder = reminder
      ..notifyMatesNotDone = matesNotDone ?? me.notifyMatesNotDone
      ..notifyNotice = notice
      ..notifyAddedToRotation = addedToRotation
      ..notifyNightSummary = nightSummary ?? me.notifyNightSummary;
    await Mate.db.updateRow(session, me);
    await broadcast(session, flat.id!, FlatChangeKind.flat);
    return me;
  }

  /// Sets the Flat-wide Away rule.
  Future<Flat> setAwayRule(Session session, AwayRule rule) async {
    final (:me, :flat) = await requireAdmin(session);
    flat.awayRule = rule;
    await Flat.db.updateRow(session, flat);
    await broadcast(session, flat.id!, FlatChangeKind.flat);
    return flat;
  }

  /// Marks a newly joined Mate as seen by the Admin, adding them to the end
  /// of each of [choreIds]' Rotations. Does nothing if they were already
  /// welcomed (say, from the Admin's other phone).
  Future<void> welcomeMate(
    Session session,
    UuidValue mateId,
    List<UuidValue> choreIds,
  ) async {
    final (:me, :flat) = await requireAdmin(session);
    final mate = await Mate.db.findById(session, mateId);
    if (mate == null || mate.flatId != flat.id || mate.leftAt != null) {
      fail('That mate isn\'t in your flat.');
    }
    if (mate.welcomed) return;

    final chores = await Chore.db.find(
      session,
      where: (t) =>
          t.flatId.equals(flat.id!) &
          t.archived.equals(false) &
          t.id.inSet(choreIds.toSet()),
      orderBy: (t) => t.name,
    );
    final added = chores.where((c) => !c.rotation.contains(mateId)).toList();
    await session.db.transaction((tx) async {
      for (final chore in added) {
        // Appending keeps rotationIndex pointing at the same slot.
        chore.rotation = [...chore.rotation, mateId];
        await Chore.db.updateRow(session, chore, transaction: tx);
      }
      mate.welcomed = true;
      await Mate.db.updateRow(session, mate, transaction: tx);
    });
    if (added.isNotEmpty && mate.id != me.id) {
      final push = addedPush(
        me.displayName,
        added.map((c) => c.name).join(', '),
      );
      await Notifier.toMates(
        session,
        [mate.id!],
        title: push.title,
        body: push.body,
        kind: NotifyKind.addedToRotation,
      );
    }
    await broadcast(session, flat.id!, FlatChangeKind.flat);
  }

  /// Records that the signed-in Mate finished onboarding. Keeps the first
  /// time if called again.
  Future<Mate> finishOnboarding(Session session) async {
    final (:me, flat: _) = await requireMate(session);
    if (me.onboardedAt != null) return me;
    me.onboardedAt = DateTime.now().toUtc();
    return Mate.db.updateRow(session, me);
  }

  /// Hands the Admin role to another Mate.
  Future<void> transferAdmin(Session session, UuidValue mateId) async {
    final (:me, :flat) = await requireAdmin(session);
    final other = await Mate.db.findById(session, mateId);
    if (other == null || other.flatId != flat.id || other.leftAt != null) {
      fail('That mate isn\'t in your flat.');
    }
    flat.adminMateId = other.id;
    await Flat.db.updateRow(session, flat);
    await Notifier.toMates(
      session,
      [other.id!],
      title: 'You\'re now the admin of ${flat.name}',
      body: '${me.displayName} handed the admin role to you.',
    );
    await broadcast(session, flat.id!, FlatChangeKind.flat);
  }

  /// Removes a Mate from the Flat. The Admin can remove anyone; anyone can
  /// remove themselves. The Admin must hand over the role before leaving,
  /// unless they're the last Mate.
  Future<void> removeMate(Session session, UuidValue mateId) async {
    final (:me, :flat) = await requireMate(session);
    final isAdmin = flat.adminMateId == me.id;
    if (mateId != me.id && !isAdmin) fail('Only the admin can remove mates.');

    final mate = await Mate.db.findById(session, mateId);
    if (mate == null || mate.flatId != flat.id || mate.leftAt != null) {
      fail('That mate isn\'t in your flat.');
    }
    if (mate.id == flat.adminMateId) {
      final others = (await activeMates(
        session,
        flat.id!,
      )).where((m) => m.id != mate.id);
      if (others.isNotEmpty) {
        fail('Hand the admin role to another mate before leaving.');
      }
    }

    mate.leftAt = DateTime.now().toUtc();
    await Mate.db.updateRow(session, mate);
    await TurnService.onMateLeft(session, flat, mate);
    await broadcast(session, flat.id!, FlatChangeKind.flat);
  }

  /// Leaves the caller's Flat.
  Future<void> leave(Session session) async {
    final me = await findCurrentMate(session);
    if (me == null) return;
    await removeMate(session, me.id!);
  }

  /// Emits whenever something in the caller's Flat changes, so open apps
  /// can refresh.
  Stream<FlatChange> changes(Session session) async* {
    final (:me, :flat) = await requireMate(session);
    yield* session.messages.createStream<FlatChange>(flatChannel(flat.id!));
  }

  /// Registers this device for push notifications.
  Future<void> registerDevice(Session session, String token) async {
    final authUserId = currentUserId(session);
    final existing = await DeviceToken.db.findFirstRow(
      session,
      where: (t) => t.token.equals(token),
    );
    if (existing == null) {
      await DeviceToken.db.insertRow(
        session,
        DeviceToken(authUserId: authUserId, token: token),
      );
    } else {
      // Saved even when unchanged, so updatedAt shows the token is still live.
      existing.authUserId = authUserId;
      await DeviceToken.db.updateRow(session, existing);
    }
  }

  Future<MyFlat> _myFlat(Session session, Mate me) async {
    final flat = await Flat.db.findById(session, me.flatId);
    return MyFlat(
      flat: flat!,
      me: me,
      mates: await activeMates(session, me.flatId),
    );
  }

  /// The first colour no active Mate has; wraps round when all are taken.
  Future<MateColor> _freeColor(Session session, UuidValue flatId) async {
    final mates = await activeMates(session, flatId);
    final taken = mates.map((m) => m.color).toSet();
    return MateColor.values.firstWhere(
      (c) => !taken.contains(c),
      orElse: () => MateColor.values[mates.length % MateColor.values.length],
    );
  }

  static const _alphabet = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';

  /// An Invite works for 7 days from when it was made.
  static DateTime _inviteExpiry() =>
      DateTime.now().toUtc().add(const Duration(days: 7));

  Future<String> _newInviteCode(Session session) async {
    final random = Random.secure();
    while (true) {
      final code = List.generate(
        6,
        (_) => _alphabet[random.nextInt(_alphabet.length)],
      ).join();
      final taken = await Flat.db.count(
        session,
        where: (t) => t.inviteCode.equals(code),
      );
      if (taken == 0) return code;
    }
  }
}

String _required(String value, String label) {
  final v = value.trim();
  if (v.isEmpty) fail('$label can\'t be empty.');
  if (v.length > 40) fail('$label is too long.');
  return v;
}
