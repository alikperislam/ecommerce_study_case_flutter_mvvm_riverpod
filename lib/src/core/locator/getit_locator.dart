import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../widgets/custom_snackbar.dart';

class GetitLocator {
  //? GetIt instance
  static final getIt = GetIt.instance;
  static void setup() {
    //? Snackbar - DI
    getIt.registerLazySingleton<CustomSnackbar>(
      () => CustomSnackbar.instance,
    );
    //? InternetChecker - DI
    getIt.registerLazySingleton<InternetConnectionChecker>(
      () => InternetConnectionChecker.instance,
    );
  }
}
