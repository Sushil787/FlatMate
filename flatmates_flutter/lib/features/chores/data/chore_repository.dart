import 'package:flatmates_client/flatmates_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/client_provider.dart';

ChoreRepository _choreRepository(Ref ref) =>
    ChoreRepository(ref.watch(clientProvider));

final choreRepositoryProvider = Provider<ChoreRepository>(_choreRepository);

/// Chores and Turns on the server.
class ChoreRepository {
  ChoreRepository(this._client);

  final Client _client;

  Future<List<Chore>> list() => _client.chore.list();

  Future<List<Turn>> activeTurns() => _client.chore.activeTurns();

  /// Turns on the days [from]..[to] (see day.dart).
  Future<List<Turn>> turnsBetween(DateTime from, DateTime to) =>
      _client.chore.turnsBetween(from, to);

  Future<Chore> create({
    required String name,
    required Duration period,
    required DateTime startDay,
    required List<int> rotation,
  }) => _client.chore.create(name, period, startDay, rotation);

  Future<Chore> update({
    required int choreId,
    required String name,
    required Duration period,
    required List<int> rotation,
  }) => _client.chore.update(choreId, name, period, rotation);

  Future<void> archive(int choreId) => _client.chore.archive(choreId);

  Future<Turn> markDone(int turnId) => _client.chore.markDone(turnId);

  Future<Turn> undoDone(int turnId) => _client.chore.undoDone(turnId);

  Future<List<SwapDebt>> swapDebts() => _client.chore.swapDebts();
}
