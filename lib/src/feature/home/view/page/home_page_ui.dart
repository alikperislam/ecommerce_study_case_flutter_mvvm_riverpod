import 'package:ecommerce_case_study/src/core/extentions/string_extentions.dart';
import 'package:ecommerce_case_study/src/core/init/localization/locale_keys.g.dart';
import 'package:ecommerce_case_study/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/theme/system_theme.dart';
import '../../../../core/widgets/custom_appbar.dart';

class HomePageUi extends StatelessWidget {
  const HomePageUi({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemTheme.systemPanelColors(
        screen: SystemThemeScreenEnum.general,
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.whiteColor,
          appBar: CustomAppbar(
            title: LocaleKeys.catalogTitle.locale,
            showBackButton: false,
          ),
          body: const Column(
            children: [
              //?
            ],
          ),
        ),
      ),
    );
  }
}
