import 'package:ecommerce_case_study/src/core/extentions/string_extentions.dart';
import 'package:ecommerce_case_study/src/core/init/localization/locale_keys.g.dart';
import 'package:ecommerce_case_study/src/core/widgets/custom_snackbar.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_constants.dart';
part 'login_state.dart';

class LoginNotifier extends Notifier<LoginState> {
  final CustomSnackbar snackbar;
  LoginNotifier(this.snackbar);
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

  void submit(BuildContext context) {
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
    if (!passwordRegex.hasMatch(state.password)) {
      snackbar.showCustomSnackbar(
        context: context,
        message: LocaleKeys.errorPasswordFormat.locale,
      );
      return;
    }
    //Todo: rememberMe kontrolunu yap.
    //? Simulate a submit action
    state = state.copyWith(isSubmitting: true);
    //? Simulate API call delay
    Future.delayed(const Duration(seconds: 2), () {
      state = state.copyWith(isSubmitting: false);
      //? Handle success or failure here
    });
  }

  //? reset state
  void reset() {
    state = const LoginState();
  }
}
