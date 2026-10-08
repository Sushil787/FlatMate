import 'package:flatmates_client/flatmates_client.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/client_provider.dart';

FlatRepository _flatRepository(Ref ref) =>
    FlatRepository(ref.watch(clientProvider));

final flatRepositoryProvider = Provider<FlatRepository>(_flatRepository);

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

  Future<Flat> rename(String name) => _client.flat.rename(name);

  Future<Mate> setMyName(String displayName) =>
      _client.flat.setMyName(displayName);

  Future<Mate> setMyColor(MateColor color) => _client.flat.setMyColor(color);

  /// Saves [me]'s notify* switches.
  Future<Mate> setNotifications(Mate me) => _client.flat.setNotifications(
    turnStarts: me.notifyTurnStarts,
    reminder: me.notifyReminder,
    missed: me.notifyMissed,
    notice: me.notifyNotice,
    addedToRotation: me.notifyAddedToRotation,
  );

  Future<void> transferAdmin(int mateId) => _client.flat.transferAdmin(mateId);

  Future<void> removeMate(int mateId) => _client.flat.removeMate(mateId);

  Future<void> leave() => _client.flat.leave();

  Stream<FlatChange> changes() => _client.flat.changes();
}
