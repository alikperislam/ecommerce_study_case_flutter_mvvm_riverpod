import 'package:ecommerce_case_study/src/feature/book_details/model/fav_request_model.dart';

abstract class IFavService {
  Future<bool> postUnlike({
    required FavRequestModel request,
    required String token,
  });
  Future<bool> postLike({
    required FavRequestModel request,
    required String token,
  });
}
