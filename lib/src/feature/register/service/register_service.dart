import 'package:dio/dio.dart';
import 'package:ecommerce_case_study/src/feature/register/service/i_register_service.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../model/register_request_model.dart';
import '../model/register_response_model.dart';

class RegisterService implements IRegisterService {
  final Dio _dio;
  RegisterService(this._dio);

  @override
  Future<RegisterResponseModel?> postRegisterUser({
    required RegisterRequestModel request,
  }) async {
    try {
      Response response = await _dio.post(kRegisterUrl, data: request.toJson());
      if (response.statusCode == 200 || response.statusCode == 201) {
        return RegisterResponseModel.fromJson(response.data);
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
