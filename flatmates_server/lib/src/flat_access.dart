import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import 'generated/protocol.dart';

/// Throws a [FlatmatesException] the app can show as-is.
Never fail(String message) => throw FlatmatesException(message: message);

/// The signed-in user. Endpoints require login, so this is never null.
UuidValue currentUserId(Session session) => session.authenticated!.authUserId;

/// The signed-in user's Mate record, or null when they're not in a Flat.
Future<Mate?> findCurrentMate(Session session) async {
  final authUserId = currentUserId(session);
  return Mate.db.findFirstRow(
    session,
    where: (t) => t.authUserId.equals(authUserId) & t.leftAt.equals(null),
  );
}

/// The signed-in user's Mate record and Flat; fails when not in a Flat.
Future<({Mate me, Flat flat})> requireMate(Session session) async {
  final me = await findCurrentMate(session);
  if (me == null) fail('You are not in a flat yet.');
  final flat = await Flat.db.findById(session, me.flatId);
  return (me: me, flat: flat!);
}

/// Like [requireMate], but only for the Flat's Admin.
Future<({Mate me, Flat flat})> requireAdmin(Session session) async {
  final access = await requireMate(session);
  if (access.flat.adminMateId != access.me.id) {
    fail('Only the admin can do that.');
  }
  return access;
}

/// The Mates currently in a Flat.
Future<List<Mate>> activeMates(Session session, int flatId) => Mate.db.find(
  session,
  where: (t) => t.flatId.equals(flatId) & t.leftAt.equals(null),
  orderBy: (t) => t.joinedAt,
);

String flatChannel(int flatId) => 'flat-$flatId';

/// Tells every open app in the Flat to refresh [kind].
Future<void> broadcast(Session session, int flatId, FlatChangeKind kind) =>
    session.messages.postMessage(flatChannel(flatId), FlatChange(kind: kind));
