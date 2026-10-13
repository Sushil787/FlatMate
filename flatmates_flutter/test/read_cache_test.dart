import 'dart:io';

import 'package:flatmates_client/flatmates_client.dart';
import 'package:flatmates_flutter/core/providers/read_cache.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/fakes.dart';

void main() {
  late Directory dir;
  late ProviderContainer container;
  late ReadCache cache;

  setUp(() async {
    dir = await Directory.systemTemp.createTemp('cache');
    final path = '${dir.path}/cache.db';
    final client = Client('http://localhost:1/');
    final db = CacheDb(path, () => client.createSession(path));
    await db.open();
    container = ProviderContainer(
      overrides: [cacheDbProvider.overrideWithValue(db)],
    );
    cache = container.read(readCacheProvider.notifier);
    cache.goLive();
  });

  tearDown(() async {
    await container.read(cacheDbProvider)?.session?.close();
    container.dispose();
    await dir.delete(recursive: true);
  });

  GroceryItem item(int n) => GroceryItem(
    id: uid(n),
    flatId: uid(10),
    name: 'Item $n',
    addedByMateId: uid(1),
    createdAt: DateTime.utc(2026, 10, n),
  );

  Future<List<GroceryItem>> read(
    Future<List<GroceryItem>> Function() fetch, {
    bool failInsert = false,
  }) => cache.read(
    'grocery',
    fetch,
    load: (db) => GroceryItem.db.find(db, orderBy: (t) => t.createdAt),
    clear: (db, tx) => GroceryItem.db.deleteWhere(
      db,
      where: (t) => t.id.notEquals(null),
      transaction: tx,
    ),
    insert: (db, tx, items) async {
      await GroceryItem.db.insert(db, items, transaction: tx);
      if (failInsert) throw StateError('disk full');
    },
  );

  Future<List<GroceryItem>> offline() =>
      throw const ServerpodClientNetworkException('offline');

  test('offline, a read answers with what the server last said', () async {
    await read(() async => [item(1), item(2)]);
    await cache.saved;
    await read(() async => [item(2), item(3)]);
    await cache.saved;

    final saved = await read(offline);
    expect([for (final g in saved) g.id], [uid(2), uid(3)]);
    expect(container.read(readCacheProvider), isTrue);
  });

  test('a read never saved has nothing to show offline', () async {
    await expectLater(
      read(offline),
      throwsA(isA<ServerpodClientNetworkException>()),
    );
  });

  test('a save that fails leaves nothing, not the older answer', () async {
    await read(() async => [item(1)]);
    await cache.saved;
    await read(() async => [item(2)], failInsert: true);
    await cache.saved;

    await expectLater(
      read(offline),
      throwsA(isA<ServerpodClientNetworkException>()),
    );
  });
}
