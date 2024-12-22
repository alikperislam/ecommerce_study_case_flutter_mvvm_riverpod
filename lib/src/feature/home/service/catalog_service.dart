import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:ecommerce_case_study/src/core/constants/app_constants.dart';
import 'package:ecommerce_case_study/src/feature/home/model/categories/categories_response_model.dart';
import 'package:ecommerce_case_study/src/feature/home/model/products/products_response_model.dart';
import 'package:flutter/material.dart';
import '../model/images/image_request_model.dart';
import '../model/images/image_response_model.dart';
import 'i_catalog_service.dart';

class CatalogService implements ICatalogService {
  final Dio dio;
  CatalogService(this.dio);

  @override
  Future<CategoriesResponseModel?> getCategories() async {
    try {
      final response = await dio.get(kCategoriesUrl);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return CategoriesResponseModel.fromJson(response.data);
      } else {
        debugPrint('Error: ${response.statusCode} - ${response.data}');
        return null;
      }
    } catch (e) {
      debugPrint('Exception: $e');
      return null;
    }
  }

  @override
  Future<ProductsResponseModel?> getProductsByCategoryId({
    required int categoryId,
    required String token,
  }) async {
    try {
      final response = await dio.get(
        kProductsUrl + categoryId.toString(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json'
          },
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return ProductsResponseModel.fromJson(response.data);
      } else {
        debugPrint('Error: ${response.statusCode} - ${response.data}');
        return null;
      }
    } catch (e) {
      debugPrint('Exception: $e');
      return null;
    }
  }

  @override
  Future<ImageResponseModel?> getProductCover({
    required ImageRequestModel request,
    required String token,
  }) async {
    try {
      final response = await dio.post(
        kImageUrl,
        data: request.toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json'
          },
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return ImageResponseModel.fromJson(response.data);
      } else {
        debugPrint('Error: ${response.statusCode} - ${response.data}');
        return null;
      }
    } catch (e) {
      debugPrint('Exception: $e');
      return null;
    }
  }

  @override
  Future<Uint8List?> getByteImage({required String url}) async {
    try {
      final response = await dio.get(
        url,
        options: Options(
          responseType: ResponseType.bytes,
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Uint8List.fromList(response.data);
      } else {
        debugPrint('Error: ${response.statusCode} - ${response.data}');
        return null;
      }
    } catch (e) {
      debugPrint('Exception: $e');
      return null;
    }
  }
}
