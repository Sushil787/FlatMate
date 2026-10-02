// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_flat_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The signed-in user's Flat, or null when they haven't joined one.

@ProviderFor(MyFlatController)
const myFlatControllerProvider = MyFlatControllerProvider._();

/// The signed-in user's Flat, or null when they haven't joined one.
final class MyFlatControllerProvider
    extends $AsyncNotifierProvider<MyFlatController, MyFlat?> {
  /// The signed-in user's Flat, or null when they haven't joined one.
  const MyFlatControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'myFlatControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$myFlatControllerHash();

  @$internal
  @override
  MyFlatController create() => MyFlatController();
}

String _$myFlatControllerHash() => r'1a423ff755304e76c7b8759ec5762b67d6baf0ca';

/// The signed-in user's Flat, or null when they haven't joined one.

abstract class _$MyFlatController extends $AsyncNotifier<MyFlat?> {
  FutureOr<MyFlat?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<MyFlat?>, MyFlat?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<MyFlat?>, MyFlat?>,
              AsyncValue<MyFlat?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
