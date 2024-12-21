part of 'home_provider.dart';

class HomeState {
  final List<CategoryModel> categories;
  final bool isSubmitting;

  const HomeState({
    this.categories = const [],
    this.isSubmitting = false,
  });

  HomeState copyWith({
    List<CategoryModel>? categories,
    bool? isSubmitting,
  }) {
    return HomeState(
      categories: categories ?? this.categories,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }
}
