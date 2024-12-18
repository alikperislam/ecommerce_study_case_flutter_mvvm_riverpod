import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../locator/getit_locator.dart';

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
    //Todo: await UserPreferencesService.instance.init();
    //? ortam degiskenleri
    await dotenv.load(fileName: 'assets/.env');
  }
}
