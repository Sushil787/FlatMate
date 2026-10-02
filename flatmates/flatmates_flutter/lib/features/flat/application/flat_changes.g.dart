// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flat_changes.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Live change notices for the current Flat. Reconnects on its own; after
/// a reconnect it emits a `flat` change so everything is refetched.

@ProviderFor(flatChanges)
const flatChangesProvider = FlatChangesProvider._();

/// Live change notices for the current Flat. Reconnects on its own; after
/// a reconnect it emits a `flat` change so everything is refetched.

final class FlatChangesProvider
    extends
        $FunctionalProvider<
          AsyncValue<FlatChange>,
          FlatChange,
          Stream<FlatChange>
        >
    with $FutureModifier<FlatChange>, $StreamProvider<FlatChange> {
  /// Live change notices for the current Flat. Reconnects on its own; after
  /// a reconnect it emits a `flat` change so everything is refetched.
  const FlatChangesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'flatChangesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$flatChangesHash();

  @$internal
  @override
  $StreamProviderElement<FlatChange> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<FlatChange> create(Ref ref) {
    return flatChanges(ref);
  }
}

String _$flatChangesHash() => r'78d5ee83049045013438ad2dcabbff7e047d9d03';
