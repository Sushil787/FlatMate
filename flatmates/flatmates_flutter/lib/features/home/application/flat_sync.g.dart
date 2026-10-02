// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flat_sync.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Keeps every feature's data in step with the server: when a Mate changes
/// something, the affected providers refetch. Watched by the home shell.

@ProviderFor(flatSync)
const flatSyncProvider = FlatSyncProvider._();

/// Keeps every feature's data in step with the server: when a Mate changes
/// something, the affected providers refetch. Watched by the home shell.

final class FlatSyncProvider extends $FunctionalProvider<void, void, void>
    with $Provider<void> {
  /// Keeps every feature's data in step with the server: when a Mate changes
  /// something, the affected providers refetch. Watched by the home shell.
  const FlatSyncProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'flatSyncProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$flatSyncHash();

  @$internal
  @override
  $ProviderElement<void> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  void create(Ref ref) {
    return flatSync(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$flatSyncHash() => r'fa2773764b18b75c777295b34922b8155ad012ba';
