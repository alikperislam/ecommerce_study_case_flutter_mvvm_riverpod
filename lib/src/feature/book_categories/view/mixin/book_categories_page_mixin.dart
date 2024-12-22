import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

mixin BookCategoriesPageMixin<T extends ConsumerStatefulWidget>
    on ConsumerState<T> {
  late TextEditingController searchController;
  @override
  void initState() {
    //? create controller
    searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    //? stop controller
    searchController.dispose();
    super.dispose();
  }
}
