import 'package:ecommerce_case_study/src/core/extentions/string_extentions.dart';
import 'package:ecommerce_case_study/src/core/init/localization/locale_keys.g.dart';
import 'package:ecommerce_case_study/src/core/locator/providers.dart';
import 'package:ecommerce_case_study/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/system_theme.dart';
import '../../../../core/widgets/custom_appbar.dart';

class BookDetailsPageUi extends ConsumerStatefulWidget {
  const BookDetailsPageUi({super.key});

  @override
  ConsumerState<BookDetailsPageUi> createState() => _BookDetailsPageUiState();
}

class _BookDetailsPageUiState extends ConsumerState<BookDetailsPageUi> {
  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeProvider);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemTheme.systemPanelColors(
        screen: SystemThemeScreenEnum.general,
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.whiteColor,
          appBar: CustomAppbar(
            title: LocaleKeys.bookDetails.locale,
            showBackButton: true,
            onBackPressed: () => context.pop(),
          ),
          body: homeState.isSubmitting ||
                  homeState.categories.isEmpty ||
                  homeState.currentProduct == null
              ? Center(
                  child: SizedBox(
                    height: 35.h,
                    width: 35.h,
                    child: CircularProgressIndicator(
                      color: AppColors.purpleColor,
                      strokeWidth: 3.w,
                    ),
                  ),
                )
              : Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 20.h,
                  ),
                  child: const Stack(
                    children: [
                      Column(
                        children: [
                          //? image cover
                          ImageCoverWidget(),
                          //? name - author
                          BookNameAuthorWidget(),
                          //? summary
                          BookSummaryWidget(),
                          //? pay button
                          Spacer(),
                          PayButtonWidget(),
                        ],
                      ),
                      //? favourite button - like/unlike
                      FavouriteButtonWidget(),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}

class ImageCoverWidget extends ConsumerWidget {
  const ImageCoverWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeProvider);
    return Center(
      child: Container(
        height: 225.h,
        width: 160.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.r),
        ),
        //Todo: image kontrol edilecek!
        child: Image.network(
          fit: BoxFit.fill,
          homeState.currentProduct!.url,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              height: 225.h,
              width: 160.w,
              decoration: BoxDecoration(
                color: AppColors.purpleColor,
                borderRadius: BorderRadius.circular(4.r),
              ),
            );
          },
        ),
      ),
    );
  }
}

class FavouriteButtonWidget extends ConsumerWidget {
  const FavouriteButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeProvider);
    final homeNotifier = ref.read(homeProvider.notifier);
    final detailsNotifier = ref.read(detailsProvider.notifier);
    final detailsState = ref.watch(detailsProvider);
    return Stack(
      children: [
        //?
        Align(
          alignment: Alignment.topRight,
          child: InkWell(
            onTap: () async {
              //? like-unlike trigger.
              bool status = await detailsNotifier.postFavorite(
                categoryIndex: homeState.currentCategoryIndex!,
                productIndex: homeState.currentProductIndex!,
                productId: homeState.currentProduct!.id.toString(),
                context: context,
              );
              if (status) {
                homeNotifier.favClick();
              }
            },
            customBorder: const CircleBorder(),
            child: Ink(
              height: 45.h,
              width: 45.h,
              decoration: const BoxDecoration(
                color: AppColors.greyColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  homeState.currentProduct!.likesCount == 0
                      ? Icons.favorite_border_rounded
                      : Icons.favorite_rounded,
                  size: 22.r,
                  color: AppColors.purpleColor,
                ),
              ),
            ),
          ),
        ),
        //?
        if (detailsState.isSubmitting)
          Align(
            alignment: Alignment.topRight,
            child: SizedBox(
              height: 45.h,
              width: 45.h,
              child: CircularProgressIndicator(
                color: AppColors.purpleColor,
                strokeWidth: 1.5.w,
              ),
            ),
          ),
      ],
    );
  }
}

class BookNameAuthorWidget extends ConsumerWidget {
  const BookNameAuthorWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeProvider);
    return Column(
      children: [
        SizedBox(height: 5.h),
        //? book name
        Text(
          homeState.currentProduct!.name,
          style: GoogleFonts.manrope(
            textStyle: TextStyle(
              color: AppColors.blackColor,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 5.h),
        //? book author
        Text(
          homeState.currentProduct!.author,
          style: GoogleFonts.manrope(
            textStyle: TextStyle(
              color: AppColors.black60,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(height: 40.h),
      ],
    );
  }
}

class BookSummaryWidget extends ConsumerWidget {
  const BookSummaryWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //? title
        Text(
          LocaleKeys.summary.locale,
          style: GoogleFonts.manrope(
            textStyle: TextStyle(
              color: AppColors.blackColor,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 10.h),
        //? book summary
        Text(
          homeState.currentProduct!.description,
          style: GoogleFonts.manrope(
            textStyle: TextStyle(
              color: AppColors.black60,
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          maxLines: 7,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }
}

class PayButtonWidget extends ConsumerWidget {
  const PayButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeProvider);
    return InkWell(
      onTap: () {
        //? congrats!
        debugPrint(
            '${homeState.currentProduct!.name} -> ${homeState.currentProduct!.price.toString().dollar}');
      },
      borderRadius: BorderRadius.circular(4.r),
      child: Ink(
        height: 60.h,
        decoration: BoxDecoration(
          color: AppColors.orangeColor,
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            children: [
              //? book price text
              Text(
                homeState.currentProduct!.price.toString().dollar,
                style: GoogleFonts.manrope(
                  textStyle: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Spacer(),
              //? buy text
              Text(
                LocaleKeys.buy.locale,
                style: GoogleFonts.manrope(
                  textStyle: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
