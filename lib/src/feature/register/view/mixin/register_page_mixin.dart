import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/locator/providers.dart';
import '../../../../core/utils/image_manager.dart';

mixin RegisterPageMixin<T extends ConsumerStatefulWidget> on ConsumerState<T> {
  String? logo;
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    //? image pre-load
    logo != null ? null : logo = ImageManager.appLogo;
    //? create textcontroller
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    //? reset register provider state
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(registerProvider.notifier).reset();
    });
    super.initState();
  }

  @override
  void dispose() {
    //? stop textcontrollers
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
