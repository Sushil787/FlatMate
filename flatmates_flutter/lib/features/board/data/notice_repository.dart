import 'package:flatmates_client/flatmates_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/providers/client_provider.dart';

part 'notice_repository.g.dart';

@Riverpod(keepAlive: true)
NoticeRepository noticeRepository(Ref ref) => NoticeRepository(ref.watch(clientProvider));

class NoticeRepository {
  NoticeRepository(this._client);

  final Client _client;

  Future<List<Notice>> list() => _client.notice.list();

  Future<Notice> post(String text) => _client.notice.post(text);

  Future<void> setPinned(int noticeId, bool pinned) =>
      _client.notice.setPinned(noticeId, pinned);

  Future<void> delete(int noticeId) => _client.notice.delete(noticeId);
}
