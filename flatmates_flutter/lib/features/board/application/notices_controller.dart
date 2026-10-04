import 'package:flatmates_client/flatmates_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../flat/application/mate_directory.dart';
import '../data/notice_repository.dart';

part 'notices_controller.g.dart';

/// The notice board: pinned first, then newest first.
@Riverpod(keepAlive: true)
class NoticesController extends _$NoticesController {
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

  Future<void> delete(Notice notice) async {
    await _repo.delete(notice.id!);
    await refresh();
  }
}
