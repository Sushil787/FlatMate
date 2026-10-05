// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aways_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Away periods in the Flat that haven't ended yet.

@ProviderFor(AwaysController)
final awaysControllerProvider = AwaysControllerProvider._();

/// Away periods in the Flat that haven't ended yet.
final class AwaysControllerProvider
    extends $AsyncNotifierProvider<AwaysController, List<Away>> {
  /// Away periods in the Flat that haven't ended yet.
  AwaysControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'awaysControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$awaysControllerHash();

  @$internal
  @override
  AwaysController create() => AwaysController();
}

String _$awaysControllerHash() => r'8437cafcafe0fd7801fb82f6d662396143555381';

/// Away periods in the Flat that haven't ended yet.

abstract class _$AwaysController extends $AsyncNotifier<List<Away>> {
  FutureOr<List<Away>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Away>>, List<Away>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Away>>, List<Away>>,
              AsyncValue<List<Away>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
