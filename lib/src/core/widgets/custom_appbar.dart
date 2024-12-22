import 'package:ecommerce_case_study/src/core/theme/app_colors.dart';
import 'package:ecommerce_case_study/src/core/utils/image_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final VoidCallback? onBackPressed;

  const CustomAppbar({
    super.key,
    required this.title,
    required this.showBackButton,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: preferredSize.height - 1.5.h,
          decoration: const BoxDecoration(
            color: AppColors.whiteColor,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Stack(
              children: [
                //? logo or back button
                showBackButton
                    ? BackButtonWidget(onBackPressed: onBackPressed)
                    : const AppLogoWidget(),
                //? appbar title
                TitleWidget(title: title),
              ],
            ),
          ),
        ),
        const DividerWidget(),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(92.h);
}

class AppLogoWidget extends StatelessWidget {
  const AppLogoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: SvgPicture.asset(
        ImageManager.appLogo,
        width: 50.w,
      ),
    );
  }
}

class BackButtonWidget extends StatelessWidget {
  final VoidCallback? onBackPressed;
  const BackButtonWidget({
    super.key,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Transform.translate(
        offset: Offset(-5.w, 0),
        child: Material(
          color: AppColors.whiteColor,
          shape: const CircleBorder(),
          child: InkWell(
            onTap: onBackPressed,
            customBorder: const CircleBorder(),
            child: Ink(
              width: 25.w,
              height: 25.w,
              decoration: const BoxDecoration(
                color: AppColors.whiteColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 25.w,
                color: AppColors.blackColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TitleWidget extends StatelessWidget {
  final String title;
  const TitleWidget({
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Text(
        title,
        style: GoogleFonts.manrope(
          textStyle: TextStyle(
            color: AppColors.blackColor,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class DividerWidget extends StatelessWidget {
  const DividerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.5.h,
      decoration: const BoxDecoration(
        color: AppColors.greyColor,
      ),
    );
  }
}
