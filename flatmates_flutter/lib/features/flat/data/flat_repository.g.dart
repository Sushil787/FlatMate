// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flat_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(flatRepository)
final flatRepositoryProvider = FlatRepositoryProvider._();

final class FlatRepositoryProvider
    extends $FunctionalProvider<FlatRepository, FlatRepository, FlatRepository>
    with $Provider<FlatRepository> {
  FlatRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'flatRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$flatRepositoryHash();

  @$internal
  @override
  $ProviderElement<FlatRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FlatRepository create(Ref ref) {
    return flatRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FlatRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FlatRepository>(value),
    );
  }
}

String _$flatRepositoryHash() => r'dcf829c6f670cbe6c4c21b893ccfff16f33dd3af';
