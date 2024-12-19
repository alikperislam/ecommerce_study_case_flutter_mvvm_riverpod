import 'package:ecommerce_case_study/src/core/widgets/custom_snackbar.dart';
import 'package:ecommerce_case_study/src/feature/register/provider/register/register_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../../feature/login/provider/login/login_provider.dart';

//? register
final registerProvider = NotifierProvider<RegisterNotifier, RegisterState>(
  () => RegisterNotifier(
    snackbar: CustomSnackbar.instance,
    connection: InternetConnectionChecker.instance,
  ),
);

//? login
final loginProvider = NotifierProvider<LoginNotifier, LoginState>(
  () => LoginNotifier(
    snackbar: CustomSnackbar.instance,
    connection: InternetConnectionChecker.instance,
  ),
);
//Todo: others

