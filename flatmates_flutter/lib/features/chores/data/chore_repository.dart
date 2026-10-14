import 'package:flatmates_client/flatmates_client.dart' hide ChoreRepository;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serverpod_database/serverpod_database.dart';

import '../../../core/providers/client_provider.dart';
import '../../../core/providers/read_cache.dart';
import '../../../core/utils/day.dart';

ChoreRepository _choreRepository(Ref ref) => ChoreRepository(
  ref.watch(clientProvider),
  ref.watch(readCacheProvider.notifier),
);

final choreRepositoryProvider = Provider<ChoreRepository>(_choreRepository);

/// Chores and Turns on the server.
class ChoreRepository {
  ChoreRepository(this._client, this._cache);

  final Client _client;
  final ReadCache _cache;

  /// The Flat's Chores, by name.
  Future<List<Chore>> list() => _cache.read(
    'chore',
    _client.chore.list,
    load: (db) async => (await Chore.db.find(db, orderBy: (t) => t.name)),
    clear: (db, tx) => Chore.db.deleteWhere(
      db,
      where: (t) => t.id.notEquals(null),
      transaction: tx,
    ),
    insert: (db, tx, chores) => Chore.db.insert(db, chores, transaction: tx),
  );

  /// Each Chore's latest Turn (see the server's currentTurns).
  // ponytail: "today" is the phone's, the server's is the Flat's; they
  // differ only around midnight when the two timezones differ.
  Future<List<Turn>> currentTurns() {
    final today = Day.fromLocal(DateTime.now());
    return _cache.read(
      'turn:current',
      _client.chore.currentTurns,
      load: (db) async {
        final turns = await Turn.db.find(
          db,
          where: (t) => t.lastDay >= today,
          orderBy: (t) => t.day,
        );
        return ({for (final t in turns) t.choreId: t}.values.toList());
      },
      clear: (db, tx) => _clearTurns(db, tx, (t) => t.lastDay >= today),
      insert: _insertTurns,
    );
  }

  /// Real Turns on the days [from]..[to] (see day.dart).
  Future<List<Turn>> turnsBetween(DateTime from, DateTime to) {
    Expression where(TurnTable t) => (t.day <= to) & (t.lastDay >= from);
    return _cache.read(
      'turn:${from.toIso8601String()}:${to.toIso8601String()}',
      () => _client.chore.turnsBetween(from, to),
      load: (db) async =>
          (await Turn.db.find(db, where: where, orderBy: (t) => t.day)),
      clear: (db, tx) => _clearTurns(db, tx, where),
      insert: _insertTurns,
    );
  }

  /// Turns owed back under the Swap rule, oldest first.
  Future<List<SwapDebt>> swapDebts() => _cache.read(
    'swapDebt',
    _client.chore.swapDebts,
    load: (db) async =>
        (await SwapDebt.db.find(db, orderBy: (t) => t.createdAt)),
    clear: (db, tx) => SwapDebt.db.deleteWhere(
      db,
      where: (t) => t.id.notEquals(null),
      transaction: tx,
    ),
    insert: (db, tx, debts) => SwapDebt.db.insert(db, debts, transaction: tx),
  );

  /// Clears [where], and the rows about to be saved wherever they sit
  /// now: a Turn can move days (Pause).
  static Future<void> _clearTurns(
    DatabaseSession db,
    Transaction tx,
    Expression Function(TurnTable t) where,
  ) => Turn.db.deleteWhere(db, where: where, transaction: tx);

  static Future<void> _insertTurns(
    DatabaseSession db,
    Transaction tx,
    List<Turn> turns,
  ) async {
    final ids = {for (final t in turns) t.id!};
    if (ids.isNotEmpty) {
      await Turn.db.deleteWhere(
        db,
        where: (t) => t.id.inSet(ids),
        transaction: tx,
      );
    }
    await Turn.db.insert(db, turns, transaction: tx);
  }

  Future<Chore> create({
    required String name,
    required Duration period,
    required DateTime startDay,
    required List<UuidValue> rotation,
  }) => _client.chore.create(name, period, startDay, rotation);

  Future<Chore> update({
    required UuidValue choreId,
    required String name,
    required Duration period,
    required List<UuidValue> rotation,
  }) => _client.chore.update(choreId, name, period, rotation);

  Future<void> archive(UuidValue choreId) => _client.chore.archive(choreId);

  Future<Turn> markDone(UuidValue turnId) => _client.chore.markDone(turnId);

  Future<Turn> undoDone(UuidValue turnId) => _client.chore.undoDone(turnId);
}
