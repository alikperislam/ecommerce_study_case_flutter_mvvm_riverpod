part of 'register_provider.dart';

class RegisterState {
  final String name;
  final String email;
  final String password;
  final bool isSubmitting;

  const RegisterState({
    this.name = '',
    this.email = '',
    this.password = '',
    this.isSubmitting = false,
  });

  RegisterState copyWith({
    String? name,
    String? email,
    String? password,
    bool? isSubmitting,
  }) {
    return RegisterState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }
}
