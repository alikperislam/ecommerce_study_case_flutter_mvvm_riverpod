import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import '../../feature/login/view/page/login_page_ui.dart';
import 'app_route_named.dart';
import '../../feature/splash/view/page/splash_page_ui.dart';

class AppRoutes {
  //? lazy singleton
  AppRoutes._();
  static AppRoutes? _instance;
  static AppRoutes get instance => _instance ??= AppRoutes._();
  //? go_router configurations
  final router = GoRouter(
    initialLocation: AppRouteNamed.splashPage.path,
    debugLogDiagnostics: true, //? debugging
    routes: [
      //? splash page
      GoRoute(
        path: AppRouteNamed.splashPage.path,
        pageBuilder: (context, state) {
          return buildCustomTransitionPage(
            state: state,
            child: const SplashPageUi(),
          );
        },
        onExit: (context, state) {
          return false;
        },
      ),
      //? login page
      GoRoute(
        path: AppRouteNamed.loginPage.path,
        pageBuilder: (context, state) {
          return buildCustomTransitionPage(
            state: state,
            child: const LoginPageUi(),
          );
        },
        onExit: (context, state) {
          return false;
        },
      ),
    ],
  );
}

CustomTransitionPage buildCustomTransitionPage({
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
        child: child,
      );
    },
  );
}