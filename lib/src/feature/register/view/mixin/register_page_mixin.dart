import 'package:flutter/material.dart';
import '../../../../core/utils/image_manager.dart';

mixin RegisterPageMixin<T extends StatefulWidget> on State<T> {
  String? logo;
  @override
  void initState() {
    //? image pre-load
    logo = ImageManager.appLogo;
    super.initState();
  }
}
