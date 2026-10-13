import 'package:flatmates_client/flatmates_client.dart' hide NoticeRepository;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serverpod_database/serverpod_database.dart';

import '../../../core/providers/client_provider.dart';
import '../../../core/providers/read_cache.dart';

NoticeRepository _noticeRepository(Ref ref) => NoticeRepository(
  ref.watch(clientProvider),
  ref.watch(readCacheProvider.notifier),
);

final noticeRepositoryProvider = Provider<NoticeRepository>(_noticeRepository);

class NoticeRepository {
  NoticeRepository(this._client, this._cache);

  final Client _client;
  final ReadCache _cache;

  /// The notice board, pinned first, then newest first, each Notice with
  /// who said Got it.
  Future<List<Notice>> list() async {
    final (notices, gotIts) = await _cache.read(
      'notice',
      () => (_client.notice.list(), _client.notice.gotIts()).wait,
      load: (db) async {
        final notices = await Notice.db.find(
          db,
          orderBy: (t) => t.createdAt.desc(),
        );
        return (
          [
            ...notices.where((n) => n.pinned),
            ...notices.where((n) => !n.pinned),
          ],
          await NoticeGotIt.db.find(db, orderBy: (t) => t.createdAt),
        );
      },
      clear: (db, tx) async {
        await Notice.db.deleteWhere(
          db,
          where: (t) => t.id.notEquals(null),
          transaction: tx,
        );
        await NoticeGotIt.db.deleteWhere(
          db,
          where: (t) => t.id.notEquals(null),
          transaction: tx,
        );
      },
      insert: (db, tx, board) async {
        await Notice.db.insert(db, board.$1, transaction: tx);
        await NoticeGotIt.db.insert(db, board.$2, transaction: tx);
      },
    );
    return [
      for (final n in notices)
        n.copyWith(
          gotItMateIds: [
            for (final g in gotIts)
              if (g.noticeId == n.id) g.mateId,
          ],
        ),
    ];
  }

  Future<Notice> post(String text) => _client.notice.post(text);

  Future<void> setPinned(UuidValue noticeId, bool pinned) =>
      _client.notice.setPinned(noticeId, pinned);

  Future<void> gotIt(UuidValue noticeId) => _client.notice.gotIt(noticeId);

  Future<void> delete(UuidValue noticeId) => _client.notice.delete(noticeId);
}
