// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grocery_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(groceryRepository)
const groceryRepositoryProvider = GroceryRepositoryProvider._();

final class GroceryRepositoryProvider
    extends
        $FunctionalProvider<
          GroceryRepository,
          GroceryRepository,
          GroceryRepository
        >
    with $Provider<GroceryRepository> {
  const GroceryRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'groceryRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$groceryRepositoryHash();

  @$internal
  @override
  $ProviderElement<GroceryRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GroceryRepository create(Ref ref) {
    return groceryRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GroceryRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GroceryRepository>(value),
    );
  }
}

String _$groceryRepositoryHash() => r'c349fa62cc76004d0436500fc58c421a086e7d1d';
