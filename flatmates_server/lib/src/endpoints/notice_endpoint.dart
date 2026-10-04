import 'package:serverpod/serverpod.dart';

import '../flat_access.dart';
import '../generated/protocol.dart';
import '../notify/notifier.dart';

/// The Flat's notice board.
class NoticeEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// Pinned Notices first, then newest first.
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
    await Notifier.toFlat(
      session,
      flat.id!,
      title: '${me.displayName} posted a notice',
      body: notice.text,
      exceptMateId: me.id,
    );
    await broadcast(session, flat.id!, FlatChangeKind.notices);
    return notice;
  }

  Future<void> setPinned(Session session, int noticeId, bool pinned) async {
    final (:me, :flat) = await requireAdmin(session);
    final notice = await Notice.db.findById(session, noticeId);
    if (notice == null || notice.flatId != flat.id) fail('Notice not found.');
    notice.pinned = pinned;
    await Notice.db.updateRow(session, notice);
    await broadcast(session, flat.id!, FlatChangeKind.notices);
  }

  /// Deletes a Notice; only its author or the Admin can.
  Future<void> delete(Session session, int noticeId) async {
    final (:me, :flat) = await requireMate(session);
    final notice = await Notice.db.findById(session, noticeId);
    if (notice == null || notice.flatId != flat.id) fail('Notice not found.');
    if (notice.mateId != me.id && flat.adminMateId != me.id) {
      fail('Only the author or the admin can delete this.');
    }
    await Notice.db.deleteRow(session, notice);
    await broadcast(session, flat.id!, FlatChangeKind.notices);
  }
}
