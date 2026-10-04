// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mate_directory.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The current [MateDirectory]. Only read it inside the home shell, where
/// the user is known to be in a Flat.

@ProviderFor(MateDirectoryNotifier)
final mateDirectoryProvider = MateDirectoryNotifierProvider._();

/// The current [MateDirectory]. Only read it inside the home shell, where
/// the user is known to be in a Flat.
final class MateDirectoryNotifierProvider
    extends $NotifierProvider<MateDirectoryNotifier, MateDirectory> {
  /// The current [MateDirectory]. Only read it inside the home shell, where
  /// the user is known to be in a Flat.
  MateDirectoryNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mateDirectoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mateDirectoryNotifierHash();

  @$internal
  @override
  MateDirectoryNotifier create() => MateDirectoryNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MateDirectory value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MateDirectory>(value),
    );
  }
}

String _$mateDirectoryNotifierHash() =>
    r'a39fd04a629d76ffe8f733c4abda4ae901c20a5c';

/// The current [MateDirectory]. Only read it inside the home shell, where
/// the user is known to be in a Flat.

abstract class _$MateDirectoryNotifier extends $Notifier<MateDirectory> {
  MateDirectory build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<MateDirectory, MateDirectory>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<MateDirectory, MateDirectory>,
              MateDirectory,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// The current Flat's id, or null. Data providers watch this so they reload
/// when the user joins or leaves a Flat; it only notifies when the id
/// itself changes.

@ProviderFor(currentFlatId)
final currentFlatIdProvider = CurrentFlatIdProvider._();

/// The current Flat's id, or null. Data providers watch this so they reload
/// when the user joins or leaves a Flat; it only notifies when the id
/// itself changes.

final class CurrentFlatIdProvider extends $FunctionalProvider<int?, int?, int?>
    with $Provider<int?> {
  /// The current Flat's id, or null. Data providers watch this so they reload
  /// when the user joins or leaves a Flat; it only notifies when the id
  /// itself changes.
  CurrentFlatIdProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentFlatIdProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentFlatIdHash();

  @$internal
  @override
  $ProviderElement<int?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  int? create(Ref ref) {
    return currentFlatId(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int?>(value),
    );
  }
}

String _$currentFlatIdHash() => r'cd736dafa32348a77762ed0f566a0dbc7ec3bb00';
