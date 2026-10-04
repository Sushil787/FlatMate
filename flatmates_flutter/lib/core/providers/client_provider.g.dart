// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The Serverpod client. Created in `main` and injected with an override,
/// so tests can swap it out.

@ProviderFor(client)
final clientProvider = ClientProvider._();

/// The Serverpod client. Created in `main` and injected with an override,
/// so tests can swap it out.

final class ClientProvider extends $FunctionalProvider<Client, Client, Client>
    with $Provider<Client> {
  /// The Serverpod client. Created in `main` and injected with an override,
  /// so tests can swap it out.
  ClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'clientProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$clientHash();

  @$internal
  @override
  $ProviderElement<Client> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Client create(Ref ref) {
    return client(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Client value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Client>(value),
    );
  }
}

String _$clientHash() => r'db41398d86f86b124129ce44ca5fbb5c5fdc5888';
