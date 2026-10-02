// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'groceries_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The Flat's grocery list: items to buy, plus items bought in the last day.

@ProviderFor(GroceriesController)
const groceriesControllerProvider = GroceriesControllerProvider._();

/// The Flat's grocery list: items to buy, plus items bought in the last day.
final class GroceriesControllerProvider
    extends $AsyncNotifierProvider<GroceriesController, List<GroceryItem>> {
  /// The Flat's grocery list: items to buy, plus items bought in the last day.
  const GroceriesControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'groceriesControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$groceriesControllerHash();

  @$internal
  @override
  GroceriesController create() => GroceriesController();
}

String _$groceriesControllerHash() =>
    r'3bd2e726b1d84a534b53cf09c4cc68dcb016c771';

/// The Flat's grocery list: items to buy, plus items bought in the last day.

abstract class _$GroceriesController extends $AsyncNotifier<List<GroceryItem>> {
  FutureOr<List<GroceryItem>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<List<GroceryItem>>, List<GroceryItem>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<GroceryItem>>, List<GroceryItem>>,
              AsyncValue<List<GroceryItem>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
