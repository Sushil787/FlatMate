import 'package:flatmates_client/flatmates_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'client_provider.g.dart';

/// The Serverpod client. Created in `main` and injected with an override,
/// so tests can swap it out.
@Riverpod(keepAlive: true)
Client client(Ref ref) =>
    throw UnimplementedError('clientProvider must be overridden');
