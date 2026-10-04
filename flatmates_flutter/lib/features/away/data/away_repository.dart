import 'package:flatmates_client/flatmates_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/providers/client_provider.dart';

part 'away_repository.g.dart';

@Riverpod(keepAlive: true)
AwayRepository awayRepository(Ref ref) => AwayRepository(ref.watch(clientProvider));

class AwayRepository {
  AwayRepository(this._client);

  final Client _client;

  Future<List<Away>> list() => _client.away.list();

  Future<Away> create(DateTime startsAt, DateTime endsAt) =>
      _client.away.create(startsAt, endsAt);

  Future<void> cancel(int awayId) => _client.away.cancel(awayId);
}
