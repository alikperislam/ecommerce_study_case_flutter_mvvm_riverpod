import 'package:ecommerce_case_study/src/core/extentions/string_extentions.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/init/localization/locale_keys.g.dart';
import '../../../../core/widgets/custom_snackbar.dart';
part 'register_state.dart';

class RegisterNotifier extends Notifier<RegisterState> {
  final CustomSnackbar snackbar;
  RegisterNotifier(this.snackbar);
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

  void submit(BuildContext context) {
    //? empty controller
    if (state.name.isEmpty || state.email.isEmpty || state.password.isEmpty) {
      snackbar.showCustomSnackbar(
        context: context,
        message: LocaleKeys.errorEmpty.locale,
      );
      return;
    }
    //? name controller
    if (!(nameRegex.hasMatch(state.name.trim()))) {
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
    if (!passwordRegex.hasMatch(state.password)) {
      snackbar.showCustomSnackbar(
        context: context,
        message: LocaleKeys.errorPasswordFormat.locale,
      );
      return;
    }

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
    state = const RegisterState();
  }
}
