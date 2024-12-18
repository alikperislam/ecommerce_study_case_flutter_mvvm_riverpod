import 'package:ecommerce_case_study/src/core/extentions/string_extentions.dart';
import 'package:ecommerce_case_study/src/core/router/app_route_named.dart';
import 'package:ecommerce_case_study/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/init/localization/locale_keys.g.dart';
import '../../../../core/theme/system_theme.dart';
import '../mixin/spash_page_mixin.dart';

class SplashPageUi extends StatefulWidget {
  const SplashPageUi({super.key});

  @override
  State<SplashPageUi> createState() => _SplashPageUiState();
}

class _SplashPageUiState extends State<SplashPageUi>
    with SplashPageMixin<SplashPageUi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBlueColor,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemTheme.systemPanelColors(
          screen: SystemThemeScreenEnum.splash,
        ),
        child: SafeArea(
          child: Column(
            children: [
              //? logo
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    logo!,
                    width: 200.w,
                  ),
                ),
              ),
              //? login button
              SplashButton(
                buttonColor: AppColors.orangeColor,
                bottomPixel: 0,
                buttonText: LocaleKeys.login.locale,
                textColor: AppColors.whiteColor,
              ),
              //? skip button
              SplashButton(
                buttonColor: AppColors.darkBlueColor,
                bottomPixel: 20,
                buttonText: LocaleKeys.skip.locale,
                textColor: AppColors.purpleColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SplashButton extends StatelessWidget {
  final Color buttonColor;
  final double bottomPixel;
  final String buttonText;
  final Color textColor;
  const SplashButton({
    required this.buttonColor,
    required this.bottomPixel,
    required this.buttonText,
    required this.textColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottomPixel.h),
      child: InkWell(
        onTap: () {
          //Todo: login'e git veya bu alani direkt olarak gec.
          context.push(AppRouteNamed.loginPage.path);
        },
        borderRadius: BorderRadius.circular(4.r),
        child: Ink(
          height: 60.h,
          width: 350.w,
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(4.r),
          ),
          child: Center(
            child: Text(
              buttonText,
              style: GoogleFonts.manrope(
                textStyle: TextStyle(
                  color: textColor,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
