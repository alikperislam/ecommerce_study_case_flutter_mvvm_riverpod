import 'package:ecommerce_case_study/src/core/extentions/string_extentions.dart';
import 'package:ecommerce_case_study/src/core/router/app_route_named.dart';
import 'package:ecommerce_case_study/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/init/localization/locale_keys.g.dart';
import '../../../../core/theme/system_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import '../mixin/register_page_mixin.dart';

class RegisterPageUi extends StatefulWidget {
  const RegisterPageUi({super.key});

  @override
  State<RegisterPageUi> createState() => _RegisterPageUiState();
}

class _RegisterPageUiState extends State<RegisterPageUi>
    with RegisterPageMixin<RegisterPageUi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemTheme.systemPanelColors(
          screen: SystemThemeScreenEnum.general,
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              left: 20.w,
              right: 20.w,
              top: 60.h,
              bottom: 20.h,
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        children: [
                          //? logo(svg)
                          LogoWidget(logo: logo),
                          //? wellcome text(textSpan)
                          const WellcomeTextWidget(),
                          //? name filed
                          TextFieldWidget(
                            title: LocaleKeys.nameTitle.locale,
                            hintText: LocaleKeys.nameHintText.locale,
                            visible: false,
                          ),
                          SizedBox(height: 24.h),
                          //? e-mail textfield(column)
                          TextFieldWidget(
                            title: LocaleKeys.mailTitle.locale,
                            hintText: LocaleKeys.mailHintText.locale,
                            visible: false,
                          ),
                          SizedBox(height: 24.h),
                          //? password textfield(column)
                          TextFieldWidget(
                            title: LocaleKeys.passwordTitle.locale,
                            hintText: LocaleKeys.passwordHintText.locale,
                            visible: true,
                          ),
                          //? rememberMe button - register button(row)
                          SizedBox(height: 12.5.h),
                          const RegisterButtonWidget(),
                          SizedBox(height: 12.5.h),
                          //? login button
                          const Spacer(),
                          const LoginButtonWidget(),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class LogoWidget extends StatelessWidget {
  const LogoWidget({
    super.key,
    required this.logo,
  });

  final String? logo;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SvgPicture.asset(
        logo!,
        width: 100.w,
      ),
    );
  }
}

class WellcomeTextWidget extends StatelessWidget {
  const WellcomeTextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 75.h, bottom: 60.h),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocaleKeys.welcome.locale,
              style: GoogleFonts.manrope(
                textStyle: TextStyle(
                  color: AppColors.black60,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 10.sp),
            Text(
              LocaleKeys.registerText.locale,
              style: GoogleFonts.manrope(
                textStyle: TextStyle(
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 20.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TextFieldWidget extends StatelessWidget {
  final String title;
  final String hintText;
  final bool visible;
  const TextFieldWidget({
    required this.title,
    required this.hintText,
    required this.visible,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //? text
        Text(
          title,
          style: GoogleFonts.manrope(
            textStyle: TextStyle(
              color: AppColors.blackColor,
              fontWeight: FontWeight.w600,
              fontSize: 16.sp,
            ),
          ),
        ),
        SizedBox(height: 8.h),
        //? text field
        Container(
          height: 50.h,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: AppColors.greyColor,
            borderRadius: BorderRadius.circular(4.r),
          ),
          child: TextField(
            scrollPadding: EdgeInsets.only(bottom: 150.h),
            //? hint text style
            decoration: InputDecoration(
              hintText: hintText,
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 14.h),
              hintStyle: GoogleFonts.manrope(
                textStyle: TextStyle(
                  color: AppColors.black40,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            obscureText: visible,
            textAlignVertical: TextAlignVertical.center,
            //? user text style
            style: GoogleFonts.manrope(
              textStyle: TextStyle(
                color: AppColors.black40,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class RememberTextWidget extends StatelessWidget {
  const RememberTextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 6.5.w),
      child: SizedBox(
        height: 20.h,
        child: Center(
          child: Text(
            LocaleKeys.rememberMeText.locale,
            style: GoogleFonts.manrope(
              textStyle: TextStyle(
                color: AppColors.purpleColor,
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RegisterButtonWidget extends StatelessWidget {
  const RegisterButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: () {
            //? go to login page.
            context.push(AppRouteNamed.loginPage.path);
          },
          borderRadius: BorderRadius.circular(3.r),
          child: Ink(
            height: 20.h,
            child: Center(
              child: Text(
                LocaleKeys.login.locale,
                style: GoogleFonts.manrope(
                  textStyle: TextStyle(
                    color: AppColors.purpleColor,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class LoginButtonWidget extends StatelessWidget {
  const LoginButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //Todo: register ol islemlerini tetikle.
      },
      borderRadius: BorderRadius.circular(4.r),
      child: Ink(
        height: 60.h,
        decoration: BoxDecoration(
          color: AppColors.orangeColor,
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Center(
          child: Text(
            LocaleKeys.register.locale,
            style: GoogleFonts.manrope(
              textStyle: TextStyle(
                color: AppColors.whiteColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
