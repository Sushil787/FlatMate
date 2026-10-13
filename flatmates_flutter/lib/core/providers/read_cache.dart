import 'dart:async';
import 'dart:io';

import 'package:flatmates_client/flatmates_client.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serverpod_database/serverpod_database.dart';

/// Whether [error] means the server couldn't be reached, rather than that
/// it said no.
bool isUnreachable(Object error) =>
    error is ServerpodClientNetworkException ||
    (error is ServerpodClientHttpException &&
        const {502, 503, 504}.contains(error.statusCode));

/// The SQLite file the read-only cache lives in, on this phone.
class CacheDb {
  CacheDb(this.path, this._open);

  final String path;
  final Future<ClientDatabaseSession> Function() _open;

  /// Null when the cache is off: on web, in tests, or when the file can't
  /// be opened.
  ClientDatabaseSession? session;

  /// Opens the file; one that won't open is deleted and made again.
  Future<void> open() async {
    try {
      session = await _open();
    } catch (e) {
      debugPrint('Cache would not open, starting a new one: $e');
      await wipe();
    }
  }

  /// Deletes the file and starts an empty one. The last resort when the
  /// cache can't be trusted to hold only what the server said.
  Future<void> wipe() async {
    final old = session;
    session = null;
    try {
      await old?.close();
    } catch (_) {}
    for (final suffix in ['', '-wal', '-shm', '-journal']) {
      try {
        File('$path$suffix').deleteSync();
      } on FileSystemException catch (_) {}
    }
    try {
      session = await _open();
    } catch (e) {
      debugPrint('Cache is off: $e');
    }
  }
}

/// Created in `main`; null leaves the cache off.
final cacheDbProvider = Provider<CacheDb?>((ref) => null);

/// Clears what one read call covers, inside [tx].
typedef CacheClear = Future<void> Function(DatabaseSession db, Transaction tx);

/// Writes what one read call returned, inside [tx], after its clear.
typedef CacheInsert<T> =
    Future<void> Function(DatabaseSession db, Transaction tx, T value);

/// A read-only copy of what the server last said, so the app can show it
/// while offline. Never written to by the user: every save is a server
/// answer replacing what the same read call saved before.
///
/// The state is whether some screen is showing saved data the server
/// hasn't confirmed yet: on a cold start, until the first live refresh, or
/// while the server can't be reached.
final readCacheProvider = NotifierProvider<ReadCache, bool>(ReadCache.new);

class ReadCache extends Notifier<bool> {
  /// Until the live connection is first up, each read call is answered
  /// from the cache once, so a cold start shows the last data at once.
  bool _startup = true;
  final _servedSaved = <String>{};
  final _stale = <String>{};
  Future<void> _saving = Future.value();

  @override
  bool build() => false;

  ClientDatabaseSession? get _db => ref.read(cacheDbProvider)?.session;

  /// Answers read call [key] with [fetch], and saves the answer for later
  /// without waiting. While the server can't be reached, or once on a cold
  /// start, answers from what [key] saved instead ([load]), if anything.
  /// Keys are `group` or `group:args`; reads in one group share tables.
  ///
  /// A save first [clear]s what [key] covers, then [insert]s the answer,
  /// in one transaction. If that fails, the scope is cleared on its own,
  /// and if even that fails the whole file goes: showing nothing beats
  /// showing something the server never said.
  Future<T> read<T extends Object>(
    String key,
    Future<T> Function() fetch, {
    required Future<T?> Function(DatabaseSession db) load,
    required CacheClear clear,
    required CacheInsert<T> insert,
  }) async {
    if (_db == null) return fetch();
    if (_startup && _servedSaved.add(key)) {
      final saved = await _load(key, load);
      if (saved != null) {
        _setStale(key, true);
        return saved;
      }
    }
    final T value;
    try {
      value = await fetch();
    } catch (e) {
      if (!isUnreachable(e)) rethrow;
      final saved = await _load(key, load);
      if (saved == null) rethrow;
      _setStale(key, true);
      return saved;
    }
    _setStale(key, false);
    _save(key, clear, (db, tx) => insert(db, tx, value));
    return value;
  }

  /// The live connection is up: from now on every read goes to the server.
  /// Returns whether a screen is still showing saved data, so the caller
  /// can refresh everything.
  bool goLive() {
    _startup = false;
    final stale = _stale.isNotEmpty;
    // Reads of screens closed since never come again to clear their mark.
    // ponytail: a fixed wait for the refresh; per-screen marks if it shows.
    if (stale) {
      Timer(const Duration(seconds: 10), () {
        _stale.clear();
        if (ref.mounted) state = false;
      });
    }
    return stale;
  }

  /// Forgets everything saved, e.g. on sign out or leaving the Flat.
  Future<void> clearAll() => _enqueue(() async {
    final db = _db;
    if (db == null) return;
    try {
      await db.db.transaction((tx) => clearAllTables(db, tx));
    } catch (e) {
      debugPrint('Cache clear failed, deleting it: $e');
      await ref.read(cacheDbProvider)?.wipe();
    }
  });

  /// What [key] saved, or null when it saved nothing.
  Future<T?> _load<T>(
    String key,
    Future<T?> Function(DatabaseSession db) load,
  ) async {
    final db = _db;
    if (db == null) return null;
    try {
      final saved = await CachedRead.db.findFirstRow(
        db,
        where: (t) => t.key.equals(key),
      );
      return saved == null ? null : await load(db);
    } catch (e) {
      debugPrint('Cache read failed, deleting it: $e');
      await ref.read(cacheDbProvider)?.wipe();
      return null;
    }
  }

  void _save(String key, CacheClear clear, CacheClear write) =>
      _enqueue(() async {
        final db = _db;
        if (db == null) return;
        try {
          await db.db.transaction((tx) async {
            await clear(db, tx);
            await write(db, tx);
            await CachedRead.db.deleteWhere(
              db,
              where: (t) => t.key.equals(key),
              transaction: tx,
            );
            await CachedRead.db.insertRow(
              db,
              CachedRead(key: key, savedAt: DateTime.now().toUtc()),
              transaction: tx,
            );
          });
        } catch (e) {
          debugPrint('Cache save of $key failed, clearing it: $e');
          // Reads sharing these tables may have lost rows to the clear.
          final group = key.split(':').first;
          try {
            await db.db.transaction((tx) async {
              await clear(db, tx);
              await CachedRead.db.deleteWhere(
                db,
                where: (t) => t.key.equals(group) | t.key.like('$group:%'),
                transaction: tx,
              );
            });
          } catch (e) {
            debugPrint('Cache clear of $key failed, deleting it: $e');
            await ref.read(cacheDbProvider)?.wipe();
          }
        }
      });

  /// Done once every save so far has finished.
  @visibleForTesting
  Future<void> get saved => _saving;

  /// Saves one at a time, in the order the answers came in.
  Future<void> _enqueue(Future<void> Function() job) =>
      _saving = _saving.then((_) => job());

  void _setStale(String key, bool stale) {
    stale ? _stale.add(key) : _stale.remove(key);
    if (ref.mounted) state = _stale.isNotEmpty;
  }
}

/// Empties every table the cache mirrors, and forgets every saved read.
Future<void> clearAllTables(DatabaseSession db, Transaction tx) async {
  await CachedRead.db.deleteWhere(
    db,
    where: (t) => t.id.notEquals(null),
    transaction: tx,
  );
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
  await Chore.db.deleteWhere(
    db,
    where: (t) => t.id.notEquals(null),
    transaction: tx,
  );
  await Turn.db.deleteWhere(
    db,
    where: (t) => t.id.notEquals(null),
    transaction: tx,
  );
  await SwapDebt.db.deleteWhere(
    db,
    where: (t) => t.id.notEquals(null),
    transaction: tx,
  );
  await Away.db.deleteWhere(
    db,
    where: (t) => t.id.notEquals(null),
    transaction: tx,
  );
  await FlatEvent.db.deleteWhere(
    db,
    where: (t) => t.id.notEquals(null),
    transaction: tx,
  );
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
  await GroceryItem.db.deleteWhere(
    db,
    where: (t) => t.id.notEquals(null),
    transaction: tx,
  );
}
