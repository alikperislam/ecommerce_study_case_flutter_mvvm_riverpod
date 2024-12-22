import 'package:ecommerce_case_study/src/core/init/cache/hive_operations.dart';
import 'package:ecommerce_case_study/src/core/widgets/custom_snackbar.dart';
import 'package:ecommerce_case_study/src/feature/book_categories/provider/book_categories_provider.dart';
import 'package:ecommerce_case_study/src/feature/book_details/service/i_fav_service.dart';
import 'package:ecommerce_case_study/src/feature/home/provider/home/home_provider.dart';
import 'package:ecommerce_case_study/src/feature/home/service/i_catalog_service.dart';
import 'package:ecommerce_case_study/src/feature/register/provider/register/register_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../../feature/book_details/provider/book_details/book_details_provider.dart';
import '../../feature/home/model/catalog/catalog_response_model.dart';
import '../../feature/login/provider/login/login_provider.dart';
import '../../feature/login/service/i_login_service.dart';
import '../../feature/register/service/i_register_service.dart';
import '../../feature/splash/provider/splash_provider.dart';
import 'getit_locator.dart';

//? splash
final splashProvider = StateNotifierProvider<SplashNotifier, int>(
  (ref) => SplashNotifier(
    cache: GetitLocator.getIt<CacheOperations>(),
  ),
);

//? register
final registerProvider = NotifierProvider<RegisterNotifier, RegisterState>(
  () => RegisterNotifier(
    snackbar: GetitLocator.getIt<CustomSnackbar>(),
    connection: GetitLocator.getIt<InternetConnectionChecker>(),
    registerService: GetitLocator.getIt<IRegisterService>(),
    cache: GetitLocator.getIt<CacheOperations>(),
  ),
);

//? login
final loginProvider = NotifierProvider<LoginNotifier, LoginState>(
  () => LoginNotifier(
    snackbar: GetitLocator.getIt<CustomSnackbar>(),
    connection: GetitLocator.getIt<InternetConnectionChecker>(),
    loginService: GetitLocator.getIt<ILoginService>(),
    cache: GetitLocator.getIt<CacheOperations>(),
  ),
);

//? home
final homeProvider = NotifierProvider<HomeNotifier, HomeState>(
  () => HomeNotifier(
    catalogService: GetitLocator.getIt<ICatalogService>(),
    cache: GetitLocator.getIt<CacheOperations>(),
  ),
);

//? book categories
final bookCategoriesProvider =
    StateNotifierProvider<BookCategoriesNotifier, List<ProductModel>>(
  (ref) => BookCategoriesNotifier(),
);

//? book details
final detailsProvider = NotifierProvider<BookDetailsNotifier, BookDetailsState>(
  () => BookDetailsNotifier(
    snackbar: GetitLocator.getIt<CustomSnackbar>(),
    connection: GetitLocator.getIt<InternetConnectionChecker>(),
    cache: GetitLocator.getIt<CacheOperations>(),
    favService: GetitLocator.getIt<IFavService>(),
  ),
);
