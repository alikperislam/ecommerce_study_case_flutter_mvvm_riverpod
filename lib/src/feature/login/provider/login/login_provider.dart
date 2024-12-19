import 'package:email_validator/email_validator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
part 'login_state.dart';

class LoginNotifier extends Notifier<LoginState> {
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

  void submit() {
    final passwordRegex = RegExp(r'^[\p{L}0-9]{6,20}$', unicode: true);
    //Todo: error durumunda bildirim goster.
    //? empty controller
    if (state.email.isEmpty || state.password.isEmpty) {
      return;
    }
    //? mail format controller
    if (!EmailValidator.validate(state.email.trim())) {
      return;
    }
    //? password controller
    if (!passwordRegex.hasMatch(state.password)) {
      return;
    }
    //Todo: rememberMe kontorlunu yap.
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
