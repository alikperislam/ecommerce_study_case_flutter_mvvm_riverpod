import 'package:email_validator/email_validator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
part 'register_state.dart';

class RegisterNotifier extends Notifier<RegisterState> {
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

  void submit() {
    final nameRegex = RegExp(r'^[\p{L}]+(\s[\p{L}]+)*$', unicode: true);
    final passwordRegex = RegExp(r'^[\p{L}0-9]{6,20}$', unicode: true);
    //Todo: error durumunda bildirim goster.
    //? empty controller
    if (state.name.isEmpty || state.email.isEmpty || state.password.isEmpty) {
      return;
    }
    //? name controller
    if (!(nameRegex.hasMatch(state.name.trim()))) {
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
