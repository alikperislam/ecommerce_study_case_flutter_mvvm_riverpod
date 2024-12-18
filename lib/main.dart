import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'src/core/constants/app_constants.dart';
import 'src/core/init/localization/language.dart';
import 'src/core/init/product_init.dart';
import 'src/core/router/app_routes.dart';

Future<void> main() async {
  //? All initialize methods
  await ProductInit().initialize();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then(
    (value) => runApp(
      EasyLocalization(
        supportedLocales: LanguageManager.instance.supportedLocales,
        fallbackLocale: LanguageManager.instance.enLocale,
        path: kLangAssetPath,
        //? Riverpod provider
        child: const ProviderScope(
          child: App(),
        ),
      ),
    ),
  );
}

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //? responsive
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        //? Router
        return MaterialApp.router(
          //? localization
          localizationsDelegates: context.localizationDelegates,
          locale: context.locale,
          supportedLocales: context.supportedLocales,
          debugShowCheckedModeBanner: false,
          routerConfig: AppRoutes.instance.router,
        );
      },
    );
  }
}
