import 'package:flatmates_client/flatmates_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The Serverpod client. Created in `main` and injected with an override,
/// so tests can swap it out.
Client _client(Ref ref) =>
    throw UnimplementedError('clientProvider must be overridden');

final clientProvider = Provider<Client>(_client);
