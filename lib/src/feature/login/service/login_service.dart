import 'package:dio/dio.dart';
import 'package:ecommerce_case_study/src/feature/login/model/login_request_model.dart';
import 'package:ecommerce_case_study/src/feature/login/service/i_login_service.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../model/login_response_model.dart';

class LoginService implements ILoginService {
  final Dio _dio;
  LoginService(this._dio);

  @override
  Future<LoginResponseModel?> postLoginUser({
    required LoginRequestModel request,
  }) async {
    try {
      Response response = await _dio.post(kLoginUrl, data: request.toJson());
      if (response.statusCode == 200 || response.statusCode == 201) {
        return LoginResponseModel.fromJson(response.data);
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
