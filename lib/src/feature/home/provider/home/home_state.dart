part of 'home_provider.dart';

class HomeState {
  final List<CategoryModel> categories;
  final CategoryModel? currentCategory;
  final ProductModel? currentProduct;
  final bool isSubmitting;
  final CatalogButtons chooseCatalog;
  final int? currentCategoryIndex;

  const HomeState({
    this.categories = const [],
    this.currentCategory,
    this.currentProduct,
    this.isSubmitting = false,
    this.chooseCatalog = CatalogButtons.all,
    this.currentCategoryIndex,
  });

  HomeState copyWith({
    List<CategoryModel>? categories,
    CategoryModel? currentCategory,
    ProductModel? currentProduct,
    bool? isSubmitting,
    CatalogButtons? chooseCatalog,
    int? currentCategoryIndex,
  }) {
    return HomeState(
      categories: categories ?? this.categories,
      currentCategory: currentCategory ?? this.currentCategory,
      currentProduct: currentProduct ?? this.currentProduct,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      chooseCatalog: chooseCatalog ?? this.chooseCatalog,
      currentCategoryIndex: currentCategoryIndex ?? this.currentCategoryIndex,
    );
  }
}
