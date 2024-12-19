part of 'login_provider.dart';

class LoginState {
  final String email;
  final String password;
  final bool rememberMe;
  final bool isSubmitting;

  const LoginState({
    this.email = '',
    this.password = '',
    this.rememberMe = false,
    this.isSubmitting = false,
  });

  LoginState copyWith({
    String? email,
    String? password,
    bool? rememberMe,
    bool? isSubmitting,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      rememberMe: rememberMe ?? this.rememberMe,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }
}
