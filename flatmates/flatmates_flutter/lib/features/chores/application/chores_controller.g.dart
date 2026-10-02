// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chores_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The Flat's Chores and their open Turns.

@ProviderFor(ChoresController)
const choresControllerProvider = ChoresControllerProvider._();

/// The Flat's Chores and their open Turns.
final class ChoresControllerProvider
    extends $AsyncNotifierProvider<ChoresController, ChoresOverview> {
  /// The Flat's Chores and their open Turns.
  const ChoresControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'choresControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$choresControllerHash();

  @$internal
  @override
  ChoresController create() => ChoresController();
}

String _$choresControllerHash() => r'5bbd77f3c0d670ddcdb4727b145f8ab1b3e77e40';

/// The Flat's Chores and their open Turns.

abstract class _$ChoresController extends $AsyncNotifier<ChoresOverview> {
  FutureOr<ChoresOverview> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<ChoresOverview>, ChoresOverview>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ChoresOverview>, ChoresOverview>,
              AsyncValue<ChoresOverview>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
