import 'dart:typed_data';
import 'package:ecommerce_case_study/src/feature/home/model/images/image_response_model.dart';
import '../model/categories/categories_response_model.dart';
import '../model/images/image_request_model.dart';
import '../model/products/products_response_model.dart';

abstract class ICatalogService {
  Future<CategoriesResponseModel?> getCategories();
  Future<Uint8List?> getByteImage({required String url});
  Future<ProductsResponseModel?> getProductsByCategoryId({
    required int categoryId,
    required String token,
  });
  Future<ImageResponseModel?> getProductCover({
    required ImageRequestModel request,
    required String token,
  });
}
