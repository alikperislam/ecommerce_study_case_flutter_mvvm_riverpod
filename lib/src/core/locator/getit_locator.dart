import 'package:dio/dio.dart';
import 'package:ecommerce_case_study/src/core/constants/app_constants.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../../feature/register/service/i_register_service.dart';
import '../../feature/register/service/register_service.dart';
import '../init/cache/hive_operations.dart';
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
    //? Dio - DI
    getIt.registerLazySingleton<Dio>(
      () => Dio(),
    );
    //? RegisterService - DI
    getIt.registerLazySingleton<IRegisterService>(
      () => RegisterService(
        getIt<Dio>(),
      ),
    );
    //? CacheOperations - DI
    getIt.registerLazySingleton<CacheOperations>(
      () => CacheOperations(kDbBox),
    );
  }
}
