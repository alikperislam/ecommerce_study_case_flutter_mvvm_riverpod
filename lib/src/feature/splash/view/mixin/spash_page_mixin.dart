import 'package:ecommerce_case_study/src/core/locator/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/utils/image_manager.dart';

mixin SplashPageMixin<T extends ConsumerStatefulWidget> on ConsumerState<T> {
  String? logo;
  @override
  void initState() {
    //? image pre-load
    logo = ImageManager.appLogo;
    //? start the countdown.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(splashProvider.notifier).startTimer(context);
    });
    super.initState();
  }
}
