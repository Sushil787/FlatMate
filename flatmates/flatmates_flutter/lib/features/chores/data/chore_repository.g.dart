// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chore_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(choreRepository)
const choreRepositoryProvider = ChoreRepositoryProvider._();

final class ChoreRepositoryProvider
    extends
        $FunctionalProvider<ChoreRepository, ChoreRepository, ChoreRepository>
    with $Provider<ChoreRepository> {
  const ChoreRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'choreRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$choreRepositoryHash();

  @$internal
  @override
  $ProviderElement<ChoreRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ChoreRepository create(Ref ref) {
    return choreRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ChoreRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ChoreRepository>(value),
    );
  }
}

String _$choreRepositoryHash() => r'442d0bc2bc0a64f1699e0888663acc48f337e2a8';
