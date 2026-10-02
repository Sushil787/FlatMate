import 'dart:math';

import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../flat_access.dart';
import '../generated/protocol.dart';
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
          awayRule: AwayRule.swap,
          createdAt: now,
        ),
        transaction: tx,
      );
      final me = await Mate.db.insertRow(
        session,
        Mate(
          flatId: flat.id!,
          authUserId: session.authenticated!.authUserId,
          displayName: displayName,
          joinedAt: now,
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

    final me = await Mate.db.insertRow(
      session,
      Mate(
        flatId: flat.id!,
        authUserId: session.authenticated!.authUserId,
        displayName: displayName,
        joinedAt: DateTime.now().toUtc(),
      ),
    );
    await Notifier.toFlat(
      session,
      flat.id!,
      title: '$displayName joined ${flat.name}',
      body: 'Say hi! The admin can add them to chores.',
      exceptMateId: me.id,
    );
    await broadcast(session, flat.id!, FlatChangeKind.flat);
    return _myFlat(session, me);
  }

  /// Replaces the Invite code; the old one stops working.
  Future<String> regenerateInvite(Session session) async {
    final (:me, :flat) = await requireAdmin(session);
    flat.inviteCode = await _newInviteCode(session);
    await Flat.db.updateRow(session, flat);
    await broadcast(session, flat.id!, FlatChangeKind.flat);
    return flat.inviteCode;
  }

  /// Sets the Flat-wide Away rule.
  Future<Flat> setAwayRule(Session session, AwayRule rule) async {
    final (:me, :flat) = await requireAdmin(session);
    flat.awayRule = rule;
    await Flat.db.updateRow(session, flat);
    await broadcast(session, flat.id!, FlatChangeKind.flat);
    return flat;
  }

  /// Hands the Admin role to another Mate.
  Future<void> transferAdmin(Session session, int mateId) async {
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
  Future<void> removeMate(Session session, int mateId) async {
    final (:me, :flat) = await requireMate(session);
    final isAdmin = flat.adminMateId == me.id;
    if (mateId != me.id && !isAdmin) fail('Only the admin can remove mates.');

    final mate = await Mate.db.findById(session, mateId);
    if (mate == null || mate.flatId != flat.id || mate.leftAt != null) {
      fail('That mate isn\'t in your flat.');
    }
    if (mate.id == flat.adminMateId) {
      final others = (await activeMates(session, flat.id!))
          .where((m) => m.id != mate.id);
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
    final authUserId = session.authenticated!.authUserId;
    final existing = await DeviceToken.db.findFirstRow(
      session,
      where: (t) => t.token.equals(token),
    );
    final now = DateTime.now().toUtc();
    if (existing == null) {
      await DeviceToken.db.insertRow(
        session,
        DeviceToken(authUserId: authUserId, token: token, updatedAt: now),
      );
    } else {
      existing
        ..authUserId = authUserId
        ..updatedAt = now;
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

  static const _alphabet = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';

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
  return v;
}
