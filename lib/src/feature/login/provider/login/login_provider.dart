import 'package:ecommerce_case_study/src/core/extentions/string_extentions.dart';
import 'package:ecommerce_case_study/src/core/init/cache/hive_operations.dart';
import 'package:ecommerce_case_study/src/core/init/localization/locale_keys.g.dart';
import 'package:ecommerce_case_study/src/core/router/app_route_named.dart';
import 'package:ecommerce_case_study/src/core/widgets/custom_snackbar.dart';
import 'package:ecommerce_case_study/src/feature/login/model/login_request_model.dart';
import 'package:ecommerce_case_study/src/feature/login/service/i_login_service.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/init/cache/hive_model.dart';
part 'login_state.dart';

class LoginNotifier extends Notifier<LoginState> {
  //? Dependencies
  final CustomSnackbar snackbar;
  final InternetConnectionChecker connection;
  final ILoginService loginService;
  final CacheOperations cache;

  LoginNotifier({
    required this.snackbar,
    required this.connection,
    required this.loginService,
    required this.cache,
  });
  @override
  LoginState build() {
    return const LoginState();
  }

  void setEmail(String email) {
    state = state.copyWith(email: email);
  }

  void setPassword(String password) {
    state = state.copyWith(password: password);
  }

  void setRememberMe(bool value) {
    state = state.copyWith(rememberMe: value);
  }

  //? reset state
  void reset() {
    state = const LoginState();
  }

  void loginController(BuildContext context) async {
    //? empty controller
    if (state.email.isEmpty || state.password.isEmpty) {
      snackbar.showCustomSnackbar(
        context: context,
        message: LocaleKeys.errorEmpty.locale,
      );
      return;
    }
    //? mail format controller
    if (!EmailValidator.validate(state.email.trim())) {
      snackbar.showCustomSnackbar(
        context: context,
        message: LocaleKeys.errorMailFormat.locale,
      );
      return;
    }
    //? password controller
    if (!kPasswordRegex.hasMatch(state.password)) {
      snackbar.showCustomSnackbar(
        context: context,
        message: LocaleKeys.errorPasswordFormat.locale,
      );
      return;
    }
    //? start progress
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
      return;
    }
    //? api request function
    if (context.mounted) await postLogin(context);
  }

  //? api request
  Future<void> postLogin(BuildContext context) async {
    await loginService
        .postLoginUser(
      request: LoginRequestModel(
        email: state.email,
        password: state.password,
      ),
    )
        .then(
      (value) {
        //? login successfull
        if (value != null && value.actionLogin != null) {
          //? update user account in cache.
          cache
              .userLogin(
            userDb: UserHiveDb(
              currentUser: state.rememberMe,
              user: UserDb(
                token: value.actionLogin!.token!,
              ),
            ),
          )
              .then(
            (_) {
              //? go to home page.
              if (context.mounted) context.push(AppRouteNamed.homePage.path);
            },
          );
        }
        //? login failed
        else {
          if (context.mounted) {
            snackbar.showCustomSnackbar(
              context: context,
              message: LocaleKeys.errorLogin.locale,
            );
          }
        }
        //? stop progress.
        state = state.copyWith(isSubmitting: false);
      },
    );
  }
}
