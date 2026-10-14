import 'package:serverpod/serverpod.dart';

import '../flat_access.dart';
import '../generated/protocol.dart';
import '../notify/digests.dart';
import '../notify/notifier.dart';

/// The Flat's notice board.
class NoticeEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// Pinned Notices first, then newest first.
  /// The Flat's Notices, pinned first, then newest first. Who said Got it
  /// comes from [gotIts].
  Future<List<Notice>> list(Session session) async {
    final (:me, :flat) = await requireMate(session);
    final notices = await Notice.db.find(
      session,
      where: (t) => t.flatId.equals(flat.id!),
      orderBy: (t) => t.createdAt.desc(),
    );
    return [
      ...notices.where((n) => n.pinned),
      ...notices.where((n) => !n.pinned),
    ];
  }

  /// Every Got it on the Flat's Notices, oldest first.
  Future<List<NoticeGotIt>> gotIts(Session session) async {
    final (:me, :flat) = await requireMate(session);
    final notices = await Notice.db.find(
      session,
      where: (t) => t.flatId.equals(flat.id!),
    );
    return NoticeGotIt.db.find(
      session,
      where: (t) => t.noticeId.inSet({for (final n in notices) n.id!}),
      orderBy: (t) => t.createdAt,
    );
  }

  Future<Notice> post(Session session, String text) async {
    final (:me, :flat) = await requireMate(session);
    if (text.trim().isEmpty) fail('Write something first.');
    final notice = await Notice.db.insertRow(
      session,
      Notice(
        flatId: flat.id!,
        mateId: me.id!,
        text: text.trim(),
        pinned: false,
      ),
    );
    final push = noticePush(me.displayName, notice.text);
    await Notifier.toFlat(
      session,
      flat.id!,
      title: push.title,
      body: push.body,
      exceptMateId: me.id,
      kind: NotifyKind.notice,
    );
    await broadcast(session, flat.id!, FlatChangeKind.notices);
    return notice;
  }

  Future<void> setPinned(
    Session session,
    UuidValue noticeId,
    bool pinned,
  ) async {
    final (:me, :flat) = await requireAdmin(session);
    final notice = await Notice.db.findById(session, noticeId);
    if (notice == null || notice.flatId != flat.id) fail('Notice not found.');
    notice.pinned = pinned;
    await Notice.db.updateRow(session, notice);
    await broadcast(session, flat.id!, FlatChangeKind.notices);
  }

  /// Says "Got it" on someone else's Notice. Saying it twice is fine.
  Future<void> gotIt(Session session, UuidValue noticeId) async {
    final (:me, :flat) = await requireMate(session);
    final notice = await Notice.db.findById(session, noticeId);
    if (notice == null || notice.flatId != flat.id) fail('Notice not found.');
    if (notice.mateId == me.id) fail('That\'s your own notice.');
    final already = await NoticeGotIt.db.count(
      session,
      where: (t) => t.noticeId.equals(noticeId) & t.mateId.equals(me.id!),
    );
    if (already > 0) return;
    await NoticeGotIt.db.insertRow(
      session,
      NoticeGotIt(noticeId: noticeId, mateId: me.id!),
    );
    await broadcast(session, flat.id!, FlatChangeKind.notices);
  }

  /// Deletes a Notice; only its author or the Admin can.
  Future<void> delete(Session session, UuidValue noticeId) async {
    final (:me, :flat) = await requireMate(session);
    final notice = await Notice.db.findById(session, noticeId);
    if (notice == null || notice.flatId != flat.id) fail('Notice not found.');
    if (notice.mateId != me.id && flat.adminMateId != me.id) {
      fail('Only the author or the admin can delete this.');
    }
    await NoticeGotIt.db.deleteWhere(
      session,
      where: (t) => t.noticeId.equals(noticeId),
    );
    await Notice.db.deleteRow(session, notice);
    await broadcast(session, flat.id!, FlatChangeKind.notices);
  }
}
