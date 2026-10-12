import 'package:flatmates_client/flatmates_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../flat/application/mate_directory.dart';
import '../data/notice_repository.dart';

/// The notice board: pinned first, then newest first.
final noticesControllerProvider =
    AsyncNotifierProvider<NoticesController, List<Notice>>(
      NoticesController.new,
    );

class NoticesController extends AsyncNotifier<List<Notice>> {
  NoticeRepository get _repo => ref.read(noticeRepositoryProvider);

  @override
  Future<List<Notice>> build() {
    ref.watch(currentFlatIdProvider);
    return ref.watch(noticeRepositoryProvider).list();
  }

  Future<void> refresh() async => state = await AsyncValue.guard(_repo.list);

  Future<void> post(String text) async {
    await _repo.post(text);
    await refresh();
  }

  Future<void> setPinned(Notice notice, bool pinned) async {
    await _repo.setPinned(notice.id!, pinned);
    await refresh();
  }

  /// Says Got it to someone else's Notice; shows at once, rolls back on error.
  Future<void> gotIt(Notice notice) async {
    final me = ref.read(mateDirectoryProvider).me.id!;
    final before = state.value;
    if (before == null) return;
    state = AsyncData([
      for (final n in before)
        n.id == notice.id
            ? n.copyWith(gotItMateIds: [...?n.gotItMateIds, me])
            : n,
    ]);
    try {
      await _repo.gotIt(notice.id!);
    } catch (_) {
      state = AsyncData(before);
      rethrow;
    }
  }

  Future<void> delete(Notice notice) async {
    await _repo.delete(notice.id!);
    await refresh();
  }
}

extension NoticeGotIts on Notice {
  /// Whether [mateId] has yet to say Got it (never true for the author).
  bool isNewFor(int? mateId) =>
      this.mateId != mateId && !(gotItMateIds?.contains(mateId) ?? false);
}
