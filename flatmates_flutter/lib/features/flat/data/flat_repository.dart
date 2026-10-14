import 'dart:async';

import 'package:flatmates_client/flatmates_client.dart' hide FlatRepository;
import 'package:flatmates_shared/flatmates_shared.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../../../core/providers/client_provider.dart';
import '../../../core/providers/read_cache.dart';

FlatRepository _flatRepository(Ref ref) => FlatRepository(
  ref.watch(clientProvider),
  ref.watch(readCacheProvider.notifier),
);

final flatRepositoryProvider = Provider<FlatRepository>(_flatRepository);

/// Flat membership and settings on the server.
class FlatRepository {
  FlatRepository(this._client, this._cache);

  final Client _client;
  final ReadCache _cache;

  /// The user's Flat, or null when they aren't in one (which empties the
  /// cache). Offline: the saved Flat and Mates.
  Future<MyFlat?> mine() async {
    try {
      return await _cache.read(
        'flat',
        () async => await _client.flat.mine() ?? (throw const _NotInFlat()),
        load: (db) async {
          final flat = await Flat.db.findFirstRow(db);
          final userId = _client.auth.authInfo?.authUserId;
          if (flat == null || userId == null) return null;
          final mates = await Mate.db.find(db, orderBy: (t) => t.joinedAt);
          final me = mates.where((m) => m.authUserId == userId).firstOrNull;
          return me == null ? null : MyFlat(flat: flat, me: me, mates: mates);
        },
        clear: (db, tx) async {
          await Flat.db.deleteWhere(
            db,
            where: (t) => t.id.notEquals(null),
            transaction: tx,
          );
          await Mate.db.deleteWhere(
            db,
            where: (t) => t.id.notEquals(null),
            transaction: tx,
          );
        },
        insert: (db, tx, mine) async {
          // Another Flat's rows can't be right for this one.
          final id = mine.flat.id!;
          final counts = await Future.wait([
            Chore.db.count(
              db,
              where: (t) => t.flatId.notEquals(id),
              transaction: tx,
            ),
            Turn.db.count(
              db,
              where: (t) => t.flatId.notEquals(id),
              transaction: tx,
            ),
            Away.db.count(
              db,
              where: (t) => t.flatId.notEquals(id),
              transaction: tx,
            ),
            FlatEvent.db.count(
              db,
              where: (t) => t.flatId.notEquals(id),
              transaction: tx,
            ),
            Notice.db.count(
              db,
              where: (t) => t.flatId.notEquals(id),
              transaction: tx,
            ),
            GroceryItem.db.count(
              db,
              where: (t) => t.flatId.notEquals(id),
              transaction: tx,
            ),
          ]);
          if (counts.any((n) => n > 0)) await clearAllTables(db, tx);
          await Flat.db.insertRow(db, mine.flat, transaction: tx);
          await Mate.db.insert(db, mine.mates, transaction: tx);
        },
      );
    } on _NotInFlat {
      unawaited(_cache.clearAll());
      return null;
    }
  }

  /// A call straight to the server, to see whether it can be reached.
  Future<void> probe() => _client.flat.mine();

  Future<MyFlat> create({
    required String flatName,
    required String myName,
  }) async {
    // The Flat's timezone decides when its days start and end.
    final tz = await FlutterTimezone.getLocalTimezone();
    return _client.flat.create(flatName, myName, tz.identifier);
  }

  Future<MyFlat> join({required String inviteCode, required String myName}) =>
      _client.flat.join(inviteCode, myName);

  Future<String> regenerateInvite() => _client.flat.regenerateInvite();

  Future<Flat> setAwayRule(AwayRule rule) => _client.flat.setAwayRule(rule);

  Future<Flat> rename(String name) => _client.flat.rename(name);

  Future<Mate> setMyName(String displayName) =>
      _client.flat.setMyName(displayName);

  Future<Mate> setMyColor(MateColor color) => _client.flat.setMyColor(color);

  /// Saves [me]'s notify* switches.
  Future<Mate> setNotifications(Mate me) => _client.flat.setNotifications(
    turnStarts: me.notifyTurnStarts,
    reminder: me.notifyReminder,
    matesNotDone: me.notifyMatesNotDone,
    notice: me.notifyNotice,
    addedToRotation: me.notifyAddedToRotation,
    nightSummary: me.notifyNightSummary,
  );

  Future<Mate> finishOnboarding() => _client.flat.finishOnboarding();

  Future<void> welcomeMate(UuidValue mateId, List<UuidValue> choreIds) =>
      _client.flat.welcomeMate(mateId, choreIds);

  Future<void> transferAdmin(UuidValue mateId) =>
      _client.flat.transferAdmin(mateId);

  Future<void> removeMate(UuidValue mateId) => _client.flat.removeMate(mateId);

  Future<void> leave() => _client.flat.leave();

  Stream<FlatChange> changes() => _client.flat.changes();
}

class _NotInFlat implements Exception {
  const _NotInFlat();
}
