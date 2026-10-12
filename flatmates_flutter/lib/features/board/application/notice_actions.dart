import 'package:flatmates_client/flatmates_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/action_notifier.dart';
import 'notices_controller.dart';

NoticesController _notices(Ref ref) =>
    ref.read(noticesControllerProvider.notifier);

/// Posting a Notice.
final postNoticeProvider = AsyncNotifierProvider.autoDispose<PostNotice, void>(
  PostNotice.new,
);

class PostNotice extends ActionNotifier {
  Future<bool> run(String text) => guard(() => _notices(ref).post(text));
}

/// Saying Got it on a Notice, by Notice id.
final gotItProvider = AsyncNotifierProvider.autoDispose
    .family<GotIt, void, int>(GotIt.new);

class GotIt extends ActionNotifier {
  GotIt(this.noticeId);

  final int noticeId;

  Future<bool> run(Notice notice) => guard(() => _notices(ref).gotIt(notice));
}

/// Pinning or unpinning a Notice, by Notice id.
final pinNoticeProvider = AsyncNotifierProvider.autoDispose
    .family<PinNotice, void, int>(PinNotice.new);

class PinNotice extends ActionNotifier {
  PinNotice(this.noticeId);

  final int noticeId;

  Future<bool> run(Notice notice, bool pinned) =>
      guard(() => _notices(ref).setPinned(notice, pinned));
}

/// Deleting a Notice, by Notice id.
final deleteNoticeProvider = AsyncNotifierProvider.autoDispose
    .family<DeleteNotice, void, int>(DeleteNotice.new);

class DeleteNotice extends ActionNotifier {
  DeleteNotice(this.noticeId);

  final int noticeId;

  Future<bool> run(Notice notice) => guard(() => _notices(ref).delete(notice));
}
