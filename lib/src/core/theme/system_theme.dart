import 'package:flutter/services.dart';
import 'app_colors.dart';

class SystemTheme {
  SystemTheme._();
  static SystemUiOverlayStyle systemPanelColors({
    required SystemThemeScreenEnum screen,
  }) {
    //? the process of adjusting the colors of the top and bottom panel of the hardware.
    switch (screen) {
      case SystemThemeScreenEnum.general:
        return const SystemUiOverlayStyle(
          //? bottom panel color code
          systemNavigationBarColor: AppColors.whiteColor,
          systemNavigationBarDividerColor: AppColors.whiteColor,
          //? top panel color code
          statusBarColor: AppColors.whiteColor,
          statusBarIconBrightness: Brightness.dark,
        );
      case SystemThemeScreenEnum.splash:
        return const SystemUiOverlayStyle(
          //? bottom panel color code
          systemNavigationBarColor: AppColors.darkBlueColor,
          systemNavigationBarDividerColor: AppColors.darkBlueColor,
          //? top panel color code
          statusBarColor: AppColors.darkBlueColor,
          statusBarIconBrightness: Brightness.light,
        );
    }
  }
}

enum SystemThemeScreenEnum { splash, general }
