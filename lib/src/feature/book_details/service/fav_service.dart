import 'package:dio/dio.dart';
import 'package:ecommerce_case_study/src/core/constants/app_constants.dart';
import 'package:ecommerce_case_study/src/feature/book_details/model/fav_request_model.dart';
import 'package:ecommerce_case_study/src/feature/book_details/service/i_fav_service.dart';
import 'package:flutter/material.dart';

class FavService implements IFavService {
  final Dio _dio;
  FavService(this._dio);

  @override
  Future<bool> postLike({
    required FavRequestModel request,
    required String token,
  }) async {
    try {
      Response response = await _dio.post(
        kLikeUrl,
        data: request.toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json'
          },
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        debugPrint('Error: ${response.statusCode} - ${response.data}');
        return false;
      }
    } catch (e) {
      debugPrint('Exception: $e');
      return false;
    }
  }

  @override
  Future<bool> postUnlike({
    required FavRequestModel request,
    required String token,
  }) async {
    try {
      Response response = await _dio.post(
        kUnlikeUrl,
        data: request.toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json'
          },
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        debugPrint('Error: ${response.statusCode} - ${response.data}');
        return false;
      }
    } catch (e) {
      debugPrint('Exception: $e');
      return false;
    }
  }
}
