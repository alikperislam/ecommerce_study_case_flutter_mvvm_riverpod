import 'package:ecommerce_case_study/src/feature/register/provider/register/register_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../feature/login/provider/login/login_provider.dart';

//? register
final registerProvider = NotifierProvider<RegisterNotifier, RegisterState>(
  () => RegisterNotifier(),
);

//? login
final loginProvider = NotifierProvider<LoginNotifier, LoginState>(
  () => LoginNotifier(),
);

//Todo: others
