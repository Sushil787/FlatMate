import 'package:flatmates_client/flatmates_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/client_provider.dart';

NoticeRepository _noticeRepository(Ref ref) =>
    NoticeRepository(ref.watch(clientProvider));

final noticeRepositoryProvider = Provider<NoticeRepository>(_noticeRepository);

class NoticeRepository {
  NoticeRepository(this._client);

  final Client _client;

  Future<List<Notice>> list() => _client.notice.list();

  Future<Notice> post(String text) => _client.notice.post(text);

  Future<void> setPinned(int noticeId, bool pinned) =>
      _client.notice.setPinned(noticeId, pinned);

  Future<void> gotIt(int noticeId) => _client.notice.gotIt(noticeId);

  Future<void> delete(int noticeId) => _client.notice.delete(noticeId);
}
