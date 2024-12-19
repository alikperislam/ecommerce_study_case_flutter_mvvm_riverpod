import '../model/register_request_model.dart';
import '../model/register_response_model.dart';

abstract class IRegisterService {
  Future<RegisterResponseModel?> postRegisterUser({
    required RegisterRequestModel request,
  });
}
