import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/locator/providers.dart';
import '../../../../core/utils/image_manager.dart';

mixin LoginPageMixin<T extends ConsumerStatefulWidget> on ConsumerState<T> {
  String? logo;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    //? image pre-load
    logo != null ? null : logo = ImageManager.appLogo;
    //? create textcontroller
    emailController = TextEditingController();
    passwordController = TextEditingController();
    //? reset login provider state
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(loginProvider.notifier).reset();
    });
    super.initState();
  }

  @override
  void dispose() {
    //? stop textcontrollers
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
