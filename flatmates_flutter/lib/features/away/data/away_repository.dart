import 'package:flatmates_client/flatmates_client.dart' hide AwayRepository;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/client_provider.dart';
import '../../../core/providers/read_cache.dart';

AwayRepository _awayRepository(Ref ref) => AwayRepository(
  ref.watch(clientProvider),
  ref.watch(readCacheProvider.notifier),
);

final awayRepositoryProvider = Provider<AwayRepository>(_awayRepository);

class AwayRepository {
  AwayRepository(this._client, this._cache);

  final Client _client;
  final ReadCache _cache;

  /// Away periods that haven't ended, soonest first.
  Future<List<Away>> list() => _cache.read(
    'away',
    _client.away.list,
    load: (db) => Away.db.find(db, orderBy: (t) => t.startDay),
    clear: (db, tx) => Away.db.deleteWhere(
      db,
      where: (t) => t.id.notEquals(null),
      transaction: tx,
    ),
    insert: (db, tx, aways) => Away.db.insert(db, aways, transaction: tx),
  );

  Future<Away> create(DateTime startDay, DateTime lastDay) =>
      _client.away.create(startDay, lastDay);

  Future<List<AwayEffect>> preview(DateTime startDay, DateTime lastDay) =>
      _client.away.preview(startDay, lastDay);

  Future<void> cancel(UuidValue awayId) => _client.away.cancel(awayId);
}
