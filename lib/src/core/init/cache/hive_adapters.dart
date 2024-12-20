import 'package:ecommerce_case_study/src/core/init/cache/hive_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

class UserHiveAdapters {
  UserHiveAdapters();
  void hiveAdapters() {
    Hive.registerAdapter(UserHiveDbAdapter());
    Hive.registerAdapter(UserDbAdapter());
  }
}
