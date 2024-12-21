import 'package:ecommerce_case_study/src/feature/home/service/i_catalog_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../../../../core/init/cache/hive_operations.dart';
import '../../../../core/widgets/custom_snackbar.dart';
import '../../model/catalog/catalog_response_model.dart';
import '../../model/images/image_request_model.dart';
part 'home_state.dart';

class HomeNotifier extends Notifier<HomeState> {
  //? Dependencies
  final CustomSnackbar snackbar;
  final InternetConnectionChecker connection;
  final ICatalogService catalogService;
  final CacheOperations cache;
  HomeNotifier({
    required this.snackbar,
    required this.connection,
    required this.catalogService,
    required this.cache,
  });
  @override
  HomeState build() {
    return const HomeState();
  }

  //? create api requests for all products belonging to categories and provide a generic category structure of type CategoryModel.
  Future<List<CategoryModel>> fetchAllData() async {
    try {
      //? retrieve user from cache for token data
      var user = await cache.getUserDb();
      //? get categories from api
      var categoriesData = await catalogService.getCategories();
      //? categories list to store all categories
      List<CategoryModel> categories = [];
      //? loop through categories
      for (var category in categoriesData!.category!) {
        final categoryId = category.id;
        final categoryName = category.name;
        //? get products by category id
        var productsData = await catalogService.getProductsByCategoryId(
          categoryId: categoryId!,
          token: user!.user.token,
        );
        //? products list to store all products
        List<ProductModel> products = [];
        //? loop through products
        for (var product in productsData!.product!) {
          //? get cover image for product
          var coverUrl = await catalogService.getProductCover(
            request: ImageRequestModel(
              fileName: product.cover,
            ),
            token: user.user.token,
          );
          //? add product to products list
          products.add(ProductModel.fromJson({
            ...product.toJson(),
            'url': coverUrl!.actionProductImage!.url.toString(),
          }));
        }
        //? add category to categories list
        categories.add(CategoryModel(
          categoryName: categoryName!,
          products: products,
        ));
      }
      //? return categories list
      return categories;
    } catch (e) {
      //? error handling
      debugPrint("error: $e");
      return [];
    }
  }
}
