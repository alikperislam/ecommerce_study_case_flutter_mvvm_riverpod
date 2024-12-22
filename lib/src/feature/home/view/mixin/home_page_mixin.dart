import 'package:ecommerce_case_study/src/core/locator/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

mixin HomePageMixin<T extends ConsumerStatefulWidget> on ConsumerState<T> {
  late TextEditingController searchController;
  @override
  void initState() {
    //? create controller
    searchController = TextEditingController();
    //? fetch categories from cache or api and set them to the state.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(homeProvider.notifier).getCategories();
    });
    super.initState();
  }

  @override
  void dispose() {
    //? stop controller
    searchController.dispose();
    super.dispose();
  }
}
