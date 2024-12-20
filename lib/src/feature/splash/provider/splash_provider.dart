import 'dart:async';
import 'package:ecommerce_case_study/src/core/router/app_route_named.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/init/cache/hive_model.dart';
import '../../../core/init/cache/hive_operations.dart';

class SplashNotifier extends StateNotifier<int> {
  Timer? _timer;
  final CacheOperations cache;
  SplashNotifier({
    required this.cache,
  }) : super(3);

  //? start the countdown.
  void startTimer(BuildContext context) {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state <= 1) {
        //? redirect to user control.
        timer.cancel();
        _userAccountCheckAndRedirect(context);
      } else {
        state = state - 1;
      }
    });
  }

  //? Page redirection is done.
  void _userAccountCheckAndRedirect(BuildContext context) async {
    UserHiveDb? user = await cache.getUserDb();
    if (user != null && user.currentUser) {
      //? go to home page
      if (context.mounted) context.push(AppRouteNamed.homePage.path);
    } else {
      //? go to login page
      if (context.mounted) context.push(AppRouteNamed.loginPage.path);
    }
  }

  //? Pressing the Skip button redirects to the necessary controls.
  void skip(BuildContext context) {
    _timer?.cancel();
    _userAccountCheckAndRedirect(context);
  }

  //? cancel or stop timer.
  void stopTimer() {
    _timer?.cancel();
  }
}
