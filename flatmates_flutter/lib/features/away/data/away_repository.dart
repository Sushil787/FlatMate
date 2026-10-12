import 'package:flatmates_client/flatmates_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/client_provider.dart';

AwayRepository _awayRepository(Ref ref) =>
    AwayRepository(ref.watch(clientProvider));

final awayRepositoryProvider = Provider<AwayRepository>(_awayRepository);

class AwayRepository {
  AwayRepository(this._client);

  final Client _client;

  Future<List<Away>> list() => _client.away.list();

  Future<Away> create(DateTime startDay, DateTime lastDay) =>
      _client.away.create(startDay, lastDay);

  Future<List<AwayEffect>> preview(DateTime startDay, DateTime lastDay) =>
      _client.away.preview(startDay, lastDay);

  Future<void> cancel(int awayId) => _client.away.cancel(awayId);
}
