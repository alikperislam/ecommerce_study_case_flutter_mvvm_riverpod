import 'package:ecommerce_case_study/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePageUi extends StatelessWidget {
  const HomePageUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Center(
          child: Text(
            'Home Page',
            style: GoogleFonts.manrope(
              textStyle: const TextStyle(
                color: AppColors.blackColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
