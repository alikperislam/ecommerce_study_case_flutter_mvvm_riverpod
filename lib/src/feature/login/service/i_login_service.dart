import 'package:ecommerce_case_study/src/feature/login/model/login_request_model.dart';
import 'package:ecommerce_case_study/src/feature/login/model/login_response_model.dart';

abstract class ILoginService {
  Future<LoginResponseModel?> postLoginUser({
    required LoginRequestModel request,
  });
}
