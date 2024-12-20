import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../constants/app_constants.dart';
import '../locator/getit_locator.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'cache/hive_adapters.dart';

class ProductInit {
  ProductInit();
  Future<void> initialize() async {
    //? widgets init
    WidgetsFlutterBinding.ensureInitialized();
    //? DI - locator init
    GetitLocator.setup();
    //? localization init
    await EasyLocalization.ensureInitialized();
    //? data storage initialization
    final dir = await path_provider.getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    UserHiveAdapters().hiveAdapters();
    dbBox = await Hive.openBox('UserStorage');
    //? environments
    await dotenv.load(fileName: 'assets/.env');
  }
}
