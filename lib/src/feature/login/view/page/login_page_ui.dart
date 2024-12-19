import 'package:ecommerce_case_study/src/core/extentions/string_extentions.dart';
import 'package:ecommerce_case_study/src/core/locator/providers.dart';
import 'package:ecommerce_case_study/src/core/router/app_route_named.dart';
import 'package:ecommerce_case_study/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/enums.dart';
import '../../../../core/init/localization/locale_keys.g.dart';
import '../../../../core/theme/system_theme.dart';
import '../mixin/login_page_mixin.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPageUi extends ConsumerStatefulWidget {
  const LoginPageUi({super.key});

  @override
  ConsumerState<LoginPageUi> createState() => _LoginPageUiState();
}

class _LoginPageUiState extends ConsumerState<LoginPageUi>
    with LoginPageMixin<LoginPageUi> {
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
                          //? e-mail textfield(column)
                          TextFieldWidget(
                            title: LocaleKeys.mailTitle.locale,
                            hintText: LocaleKeys.mailHintText.locale,
                            isPasswordField: false,
                            textController: emailController,
                            type: TextfieldType.email,
                          ),
                          SizedBox(height: 24.h),
                          //? password textfield(column)
                          TextFieldWidget(
                            title: LocaleKeys.passwordTitle.locale,
                            hintText: LocaleKeys.passwordHintText.locale,
                            isPasswordField: true,
                            textController: passwordController,
                            type: TextfieldType.password,
                          ),
                          //? rememberMe button - register button(row)
                          SizedBox(height: 12.5.h),
                          const OptionsRowWidget(),
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
              LocaleKeys.welcomeBack.locale,
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
              LocaleKeys.loginText.locale,
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

class TextFieldWidget extends ConsumerWidget {
  final String title;
  final String hintText;
  final bool isPasswordField;
  final TextEditingController textController;
  final TextfieldType type;
  const TextFieldWidget({
    required this.title,
    required this.hintText,
    required this.isPasswordField,
    required this.textController,
    required this.type,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginNotifier = ref.read(loginProvider.notifier);
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
            controller: textController,
            keyboardType: type == TextfieldType.email
                ? TextInputType.emailAddress
                : TextInputType.multiline,
            onChanged: (value) {
              (type) == TextfieldType.email
                  ? loginNotifier.setEmail(value)
                  : loginNotifier.setPassword(value);
            },
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
            obscureText: isPasswordField,
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

class OptionsRowWidget extends StatelessWidget {
  const OptionsRowWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //? remember-me checkbox
        CheckBoxWidget(),
        //? remember-me text
        RememberTextWidget(),
        Spacer(),
        //? go to register button
        RegisterButtonWidget(),
      ],
    );
  }
}

class CheckBoxWidget extends ConsumerWidget {
  const CheckBoxWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(loginProvider);
    final loginNotifier = ref.read(loginProvider.notifier);
    return InkWell(
      onTap: () {
        //? hatirla ozelligini aktif-deaktif et.
        loginNotifier.setRememberMe(!loginState.rememberMe);
      },
      borderRadius: BorderRadius.circular(3.r),
      child: Ink(
        width: 20.h,
        height: 20.h,
        decoration: BoxDecoration(
          color: loginState.rememberMe
              ? AppColors.purpleColor
              : AppColors.whiteColor,
          borderRadius: BorderRadius.circular(3.r),
          border: Border.all(
            width: 2.5.h,
            color: AppColors.purpleColor,
          ),
        ),
        child: Center(
          child: Icon(
            Icons.check,
            color: AppColors.whiteColor,
            size: 15.h,
          ),
        ),
      ),
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
    return InkWell(
      onTap: () {
        //? go to register page.
        context.push(AppRouteNamed.registerPage.path);
      },
      borderRadius: BorderRadius.circular(3.r),
      child: Ink(
        height: 20.h,
        child: Center(
          child: Text(
            LocaleKeys.register.locale,
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

class LoginButtonWidget extends ConsumerWidget {
  const LoginButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(loginProvider);
    final loginNotifier = ref.read(loginProvider.notifier);
    return InkWell(
      onTap: loginState.isSubmitting
          ? null
          : () {
              //? start the login process.
              loginNotifier.submit(context);
            },
      borderRadius: BorderRadius.circular(4.r),
      child: Ink(
        height: 60.h,
        decoration: BoxDecoration(
          color: AppColors.orangeColor,
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Center(
          child: loginState.isSubmitting
              ? SizedBox(
                  height: 25.h,
                  width: 25.h,
                  child: CircularProgressIndicator(
                    color: AppColors.whiteColor,
                    strokeWidth: 2.w,
                  ),
                )
              : Text(
                  LocaleKeys.login.locale,
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
