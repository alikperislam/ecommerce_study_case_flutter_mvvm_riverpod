import 'package:ecommerce_case_study/src/feature/home/model/catalog/catalog_response_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookCategoriesNotifier extends StateNotifier<List<ProductModel>> {
  List<ProductModel> filteredProducts = [];
  BookCategoriesNotifier() : super([]);

  //? searchfield similary control
  void searchController(String value, CategoryModel categories) {
    clearSearch();
    for (var product in categories.products) {
      if (product.name.toLowerCase().contains(value.toLowerCase())) {
        filteredProducts.add(product);
      }
    }
    state = filteredProducts;
  }

  void clearSearch() {
    filteredProducts.clear();
    state = [];
  }
}
