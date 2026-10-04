// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notices_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The notice board: pinned first, then newest first.

@ProviderFor(NoticesController)
final noticesControllerProvider = NoticesControllerProvider._();

/// The notice board: pinned first, then newest first.
final class NoticesControllerProvider
    extends $AsyncNotifierProvider<NoticesController, List<Notice>> {
  /// The notice board: pinned first, then newest first.
  NoticesControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'noticesControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$noticesControllerHash();

  @$internal
  @override
  NoticesController create() => NoticesController();
}

String _$noticesControllerHash() => r'a48a6f78a38dd907e82b8f1363149abb809df597';

/// The notice board: pinned first, then newest first.

abstract class _$NoticesController extends $AsyncNotifier<List<Notice>> {
  FutureOr<List<Notice>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Notice>>, List<Notice>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Notice>>, List<Notice>>,
              AsyncValue<List<Notice>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
