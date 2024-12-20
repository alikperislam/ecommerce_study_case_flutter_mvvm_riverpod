import 'package:ecommerce_case_study/src/core/extentions/string_extentions.dart';
import 'package:ecommerce_case_study/src/core/init/cache/hive_model.dart';
import 'package:ecommerce_case_study/src/core/router/app_route_named.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/init/cache/hive_operations.dart';
import '../../../../core/init/localization/locale_keys.g.dart';
import '../../../../core/widgets/custom_snackbar.dart';
import '../../model/register_request_model.dart';
import '../../service/i_register_service.dart';
part 'register_state.dart';

class RegisterNotifier extends Notifier<RegisterState> {
  //? Dependencys
  final CustomSnackbar snackbar;
  final InternetConnectionChecker connection;
  final IRegisterService registerService;
  final CacheOperations cache;
  RegisterNotifier({
    required this.snackbar,
    required this.connection,
    required this.registerService,
    required this.cache,
  });

  @override
  RegisterState build() {
    return const RegisterState();
  }

  void setName(String name) {
    state = state.copyWith(name: name);
  }

  void setEmail(String email) {
    state = state.copyWith(email: email);
  }

  void setPassword(String password) {
    state = state.copyWith(password: password);
  }

  //? reset state
  void reset() {
    state = const RegisterState();
  }

  void registerController(BuildContext context) async {
    //? empty controller
    if (state.name.isEmpty || state.email.isEmpty || state.password.isEmpty) {
      snackbar.showCustomSnackbar(
        context: context,
        message: LocaleKeys.errorEmpty.locale,
      );
      return;
    }
    //? name controller
    if (!(kNameRegex.hasMatch(state.name.trim()))) {
      snackbar.showCustomSnackbar(
        context: context,
        message: LocaleKeys.errorNameFormat.locale,
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
    //? start progress.
    state = state.copyWith(isSubmitting: true);
    //? internet controller
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
    if (context.mounted) await postRegister(context);
  }

  //? api request
  Future<void> postRegister(BuildContext context) async {
    await registerService
        .postRegisterUser(
      request: RegisterRequestModel(
        name: state.name,
        email: state.email,
        password: state.password,
      ),
    )
        .then(
      (value) {
        //? register successfull
        if (value != null && value.actionRegister != null) {
          //? save user account in cache.
          cache
              .userRegister(
            userDb: UserHiveDb(
              currentUser: false,
              user: UserDb(
                token: value.actionRegister!.token!,
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
        //? register failed
        else {
          if (context.mounted) {
            snackbar.showCustomSnackbar(
              context: context,
              message: LocaleKeys.errorRegister.locale,
            );
          }
        }
        //? stop progress.
        state = state.copyWith(isSubmitting: false);
      },
    );
  }
}
