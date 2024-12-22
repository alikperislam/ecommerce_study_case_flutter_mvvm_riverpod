part of 'home_provider.dart';

class HomeState {
  final List<CategoryModel> categories;
  final bool isSubmitting;
  final CatalogButtons chooseCatalog;

  const HomeState({
    this.categories = const [],
    this.isSubmitting = false,
    this.chooseCatalog = CatalogButtons.all,
  });

  HomeState copyWith({
    List<CategoryModel>? categories,
    bool? isSubmitting,
    CatalogButtons? chooseCatalog,
  }) {
    return HomeState(
      categories: categories ?? this.categories,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      chooseCatalog: chooseCatalog ?? this.chooseCatalog,
    );
  }
}
