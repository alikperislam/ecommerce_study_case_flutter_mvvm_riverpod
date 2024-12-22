import 'dart:async';
import 'package:ecommerce_case_study/src/feature/home/service/i_catalog_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/enums.dart';
import '../../../../core/init/cache/hive_operations.dart';
import '../../model/catalog/catalog_response_model.dart';
import '../../model/images/image_request_model.dart';
part 'home_state.dart';

class HomeNotifier extends Notifier<HomeState> {
  //? Dependencies
  final ICatalogService catalogService;
  final CacheOperations cache;
  HomeNotifier({
    required this.catalogService,
    required this.cache,
  });
  @override
  HomeState build() {
    return const HomeState();
  }

  void setCategories(List<CategoryModel> categories) {
    state = state.copyWith(categories: categories);
  }

  void setIsSubmitting(bool value) {
    state = state.copyWith(isSubmitting: value);
  }

  void setCurrentCategory(CategoryModel category, int index) {
    state = state.copyWith(
      currentCategory: category,
      currentCategoryIndex: index,
    );
  }

  void setCurrentProduct(ProductModel product, int index) {
    state = state.copyWith(
      currentProduct: product,
      currentProductIndex: index,
    );
  }

  void setCatalog(int index) {
    switch (index) {
      case -1:
        state = state.copyWith(chooseCatalog: CatalogButtons.all);
        break;
      case 0:
        state = state.copyWith(chooseCatalog: CatalogButtons.bestSeller);
        break;
      case 1:
        state = state.copyWith(chooseCatalog: CatalogButtons.classic);
        break;
      case 2:
        state = state.copyWith(chooseCatalog: CatalogButtons.children);
        break;
      case 3:
        state = state.copyWith(chooseCatalog: CatalogButtons.philosophy);
        break;
    }
  }

  //? If the state does not exist, create the state. but if it does exist, don't do the same process again.
  void getCategories() {
    if (state.categories.isEmpty) categoryExistingController();
  }

  //? cache and api control function
  void categoryExistingController() async {
    setIsSubmitting(true);
    final user = await cache.getUserDb();
    if (user?.user.categoryField != null &&
        user?.user.categoryField!.createdDate != null) {
      String createdDate = user!.user.categoryField!.createdDate.toString();
      bool isStale = await _isCategoryDataStale(createdDate);
      if (isStale) {
        //? there are categories in cache but they have not been updated for more than 24 hours. pull data from api.
        await _fetchAndSetCategories();
      } else {
        //? categories are available in cachte. not expired yet.
        final cachedCategories = await _fetchCategoriesFromCache();
        setCategories(cachedCategories);
        setIsSubmitting(false);
      }
    } else {
      //? there are no categories in cache. fetch from api.
      await _fetchAndSetCategories();
    }
  }

  //? date controller
  Future<bool> _isCategoryDataStale(String createdDate) async {
    final created = DateTime.parse(createdDate);
    final now = DateTime.now();
    final differenceInDays = now.difference(created).inMinutes; //! .inMinute
    return differenceInDays > 1;
  }

  //? After favorite click
  void favClick() async {
    //? Fetch categories from cache
    final cachedCategories = await _fetchCategoriesFromCache();

    //? Update categories state
    setCategories(cachedCategories);

    //? Fetch the current category and product indices
    final currentCategoryIndex = state.currentCategoryIndex;
    final currentProductIndex = state.currentProductIndex;

    if (currentCategoryIndex != null && currentProductIndex != null) {
      //? Get the updated current category and product from the cached categories
      final updatedCategory = cachedCategories[currentCategoryIndex];
      final updatedProduct = updatedCategory.products[currentProductIndex];

      //? Update the current category and product state
      setCurrentCategory(updatedCategory, currentCategoryIndex);
      setCurrentProduct(updatedProduct, currentProductIndex);
    }
  }

  //? Get the list of categories that have been converted.
  Future<List<CategoryModel>> _fetchCategoriesFromCache() async {
    return await cache.getCategoryData();
  }

  //? fetch api
  Future<void> _fetchAndSetCategories() async {
    //? fetch all data from api
    final categories = await fetchAllData();
    setCategories(categories);
    //? set categories to cache
    await cache.setCategoryData(
      createdDate: DateTime.now(),
      categories: categories,
    );
    setIsSubmitting(false);
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
            kUrl: coverUrl!.actionProductImage!.url.toString(),
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
      debugPrint("$e");
      return [];
    }
  }
}
