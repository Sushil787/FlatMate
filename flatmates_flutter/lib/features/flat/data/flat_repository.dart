import 'package:flatmates_client/flatmates_client.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/providers/client_provider.dart';

part 'flat_repository.g.dart';

@Riverpod(keepAlive: true)
FlatRepository flatRepository(Ref ref) =>
    FlatRepository(ref.watch(clientProvider));

/// Flat membership and settings on the server.
class FlatRepository {
  FlatRepository(this._client);

  final Client _client;

  Future<MyFlat?> mine() => _client.flat.mine();

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

  Future<void> transferAdmin(int mateId) => _client.flat.transferAdmin(mateId);

  Future<void> removeMate(int mateId) => _client.flat.removeMate(mateId);

  Future<void> leave() => _client.flat.leave();

  Stream<FlatChange> changes() => _client.flat.changes();
}
