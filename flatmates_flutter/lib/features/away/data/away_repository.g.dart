// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'away_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(awayRepository)
final awayRepositoryProvider = AwayRepositoryProvider._();

final class AwayRepositoryProvider
    extends $FunctionalProvider<AwayRepository, AwayRepository, AwayRepository>
    with $Provider<AwayRepository> {
  AwayRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'awayRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$awayRepositoryHash();

  @$internal
  @override
  $ProviderElement<AwayRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AwayRepository create(Ref ref) {
    return awayRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AwayRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AwayRepository>(value),
    );
  }
}

String _$awayRepositoryHash() => r'73253a2bfced1178319d364c38a8301cc07459b0';
