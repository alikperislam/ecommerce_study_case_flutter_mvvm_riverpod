import 'package:ecommerce_case_study/src/core/extentions/string_extentions.dart';
import 'package:ecommerce_case_study/src/feature/book_details/model/fav_request_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import '../../../../core/init/cache/hive_operations.dart';
import '../../../../core/init/localization/locale_keys.g.dart';
import '../../../../core/widgets/custom_snackbar.dart';
import '../../service/i_fav_service.dart';
part 'book_details_state.dart';

class BookDetailsNotifier extends Notifier<BookDetailsState> {
  //? Dependencies
  final CustomSnackbar snackbar;
  final InternetConnectionChecker connection;
  final CacheOperations cache;
  final IFavService favService;
  BookDetailsNotifier({
    required this.snackbar,
    required this.connection,
    required this.cache,
    required this.favService,
  });

  @override
  BookDetailsState build() {
    return const BookDetailsState();
  }

  String userIdFromJwt(String token) {
    final payload = JwtDecoder.decode(token);
    return payload['user_id'].toString();
  }

  Future<bool> postFavorite({
    required int categoryIndex,
    required int productIndex,
    required String productId,
    required BuildContext context,
  }) async {
    try {
      state = state.copyWith(isSubmitting: true);
      if (!(await connection.hasConnection)) {
        if (context.mounted) {
          snackbar.showCustomSnackbar(
            context: context,
            message: LocaleKeys.errorInternet.locale,
          );
        }
        //? internet fail - stop progress.
        state = state.copyWith(isSubmitting: false);
        return false;
      }
      var user = await cache.getUserDb();
      String token = user!.user.token;
      String userId = userIdFromJwt(token);

      if (user.user.categoryField?.categories[categoryIndex]
              .products[productIndex].likesCount ==
          0) {
        //? Like API
        bool result = await favService.postLike(
          request: FavRequestModel(userId: userId, productId: productId),
          token: token,
        );
        if (result) {
          await cache.setLikeData(
            categoryId: categoryIndex,
            productId: productIndex,
            like: 1,
          );
          state = state.copyWith(isSubmitting: false);
          if (context.mounted) {
            snackbar.showCustomSnackbar(
              context: context,
              message: LocaleKeys.likePush.locale,
              successMessage: true,
            );
          }
          return true;
        } else {
          state = state.copyWith(isSubmitting: false);
          return false;
        }
      } else {
        //? Unlike API
        bool result = await favService.postUnlike(
          request: FavRequestModel(userId: userId, productId: productId),
          token: token,
        );
        if (result) {
          await cache.setLikeData(
            categoryId: categoryIndex,
            productId: productIndex,
            like: 0,
          );
          state = state.copyWith(isSubmitting: false);
          if (context.mounted) {
            snackbar.showCustomSnackbar(
              context: context,
              message: LocaleKeys.unlikePush.locale,
              successMessage: true,
            );
          }
          return true;
        } else {
          state = state.copyWith(isSubmitting: false);
          return false;
        }
      }
    } catch (e) {
      debugPrint('$e');
      return false;
    }
  }
}
