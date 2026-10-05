// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chores_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The Flat's Chores and their open Turns.

@ProviderFor(ChoresController)
final choresControllerProvider = ChoresControllerProvider._();

/// The Flat's Chores and their open Turns.
final class ChoresControllerProvider
    extends $AsyncNotifierProvider<ChoresController, ChoresOverview> {
  /// The Flat's Chores and their open Turns.
  ChoresControllerProvider._()
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

String _$choresControllerHash() => r'4394a7014e2072536ab50749ad7371ab645bdb51';

/// The Flat's Chores and their open Turns.

abstract class _$ChoresController extends $AsyncNotifier<ChoresOverview> {
  FutureOr<ChoresOverview> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<ChoresOverview>, ChoresOverview>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ChoresOverview>, ChoresOverview>,
              AsyncValue<ChoresOverview>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
