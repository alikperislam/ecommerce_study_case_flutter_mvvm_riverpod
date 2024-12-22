import 'package:ecommerce_case_study/src/core/constants/enums.dart';
import 'package:ecommerce_case_study/src/core/extentions/string_extentions.dart';
import 'package:ecommerce_case_study/src/core/init/localization/locale_keys.g.dart';
import 'package:ecommerce_case_study/src/core/locator/providers.dart';
import 'package:ecommerce_case_study/src/core/router/app_route_named.dart';
import 'package:ecommerce_case_study/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/system_theme.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../mixin/home_page_mixin.dart';

class HomePageUi extends ConsumerStatefulWidget {
  const HomePageUi({super.key});

  @override
  ConsumerState<HomePageUi> createState() => _HomePageUiState();
}

class _HomePageUiState extends ConsumerState<HomePageUi>
    with HomePageMixin<HomePageUi> {
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
            title: LocaleKeys.catalogTitle.locale,
            showBackButton: false,
          ),
          body: homeState.isSubmitting || homeState.categories.isEmpty
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
              : SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 30.h,
                    ),
                    child: Column(
                      children: [
                        //? category buttons (row)
                        const CatalogButtonsWidget(),
                        //? search textfield
                        TextFieldWidget(
                          hintText: LocaleKeys.searchHintText.locale,
                          textController: searchController,
                        ),
                        //? shortCatalog (column)
                        const ShortCatalogsWidget()
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}

class CatalogButtonsWidget extends ConsumerWidget {
  const CatalogButtonsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeProvider);
    final totalCount = homeState.categories.length + 1;
    return SizedBox(
      height: 45.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: totalCount,
        separatorBuilder: (context, index) {
          return SizedBox(
            width: 10.w,
          );
        },
        itemBuilder: (context, index) {
          //? first index 'All' button
          if (index == 0) {
            return const CatalogButton(index: -1);
          }
          //? other indexes(api)
          return CatalogButton(index: index - 1);
        },
      ),
    );
  }
}

class CatalogButton extends ConsumerWidget {
  final int index;
  const CatalogButton({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeProvider);
    final homeNotifier = ref.read(homeProvider.notifier);
    return InkWell(
      onTap: () {
        //? choose a catalog.
        homeNotifier.setCatalog(index);
      },
      borderRadius: BorderRadius.circular(4.r),
      child: Ink(
        decoration: BoxDecoration(
          color: homeState.chooseCatalog.buttonIndex == index
              ? AppColors.purpleColor
              : AppColors.greyColor,
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Center(
            child: Text(
              CatalogButtons.values[index + 1].name,
              style: GoogleFonts.manrope(
                textStyle: TextStyle(
                  color: homeState.chooseCatalog.buttonIndex == index
                      ? AppColors.whiteColor
                      : AppColors.black40,
                  fontSize: 16.sp,
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

class TextFieldWidget extends ConsumerWidget {
  final String hintText;
  final TextEditingController textController;
  const TextFieldWidget({
    required this.hintText,
    required this.textController,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final homeNotifier = ref.read(homeProvider.notifier);
    return Padding(
      padding: EdgeInsets.only(top: 20.h),
      child: Container(
        height: 50.h,
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        decoration: BoxDecoration(
          color: AppColors.greyColor,
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: TextField(
          scrollPadding: EdgeInsets.only(bottom: 150.h),
          controller: textController,
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
            prefixIcon: Icon(
              Icons.search,
              color: AppColors.black40,
              size: 20.w,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                Icons.tune_rounded,
                color: AppColors.black40,
                size: 20.w,
              ),
              onPressed: () {
                //Todo: butona basildiginda arama islemini tetikle.
                debugPrint(textController.text);
              },
            ),
          ),
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
    );
  }
}

//Todo: arama ile ortaklastir.
class ShortCatalogsWidget extends ConsumerWidget {
  const ShortCatalogsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeProvider);
    if (homeState.chooseCatalog == CatalogButtons.all) {
      return Column(
        children: List.generate(4, (index) {
          return CatalogRow(categoryIndex: index);
        }),
      );
    } else {
      return CatalogRow(categoryIndex: homeState.chooseCatalog.buttonIndex);
    }
  }
}

class CatalogRow extends ConsumerWidget {
  final int categoryIndex;
  const CatalogRow({
    super.key,
    required this.categoryIndex,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.only(top: 40.h),
      child: Column(
        children: [
          //? top row
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //? category title
              Text(
                CatalogButtons.values[categoryIndex + 1].name,
                style: GoogleFonts.manrope(
                  textStyle: TextStyle(
                    color: AppColors.blackColor,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Spacer(),
              //? view button
              ViewButtonWidget(categoryIndex: categoryIndex),
            ],
          ),
          //? product row
          Padding(
            padding: EdgeInsets.only(top: 20.h),
            child: SizedBox(
              height: 140.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 2,
                separatorBuilder: (context, index) {
                  return SizedBox(
                    width: 10.w,
                  );
                },
                itemBuilder: (context, index) {
                  return ProductsWidget(
                    productIndex: index,
                    categoryIndex: categoryIndex,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ViewButtonWidget extends ConsumerWidget {
  final int categoryIndex;
  const ViewButtonWidget({
    super.key,
    required this.categoryIndex,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeProvider);
    final homeNotifier = ref.read(homeProvider.notifier);
    return InkWell(
      onTap: () {
        //? update current category
        homeNotifier.setCurrentCategory(
          homeState.categories[categoryIndex],
          categoryIndex,
        );
        //? go to categories page
        context.push(AppRouteNamed.bookCategoriesPage.path);
      },
      borderRadius: BorderRadius.circular(4.r),
      child: Text(
        LocaleKeys.viewAllButton.locale,
        style: GoogleFonts.manrope(
          textStyle: TextStyle(
            color: AppColors.orangeColor,
            fontSize: 12.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class ProductsWidget extends ConsumerWidget {
  final int productIndex;
  final int categoryIndex;
  const ProductsWidget({
    super.key,
    required this.productIndex,
    required this.categoryIndex,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeProvider);
    final homeNotifier = ref.read(homeProvider.notifier);
    return InkWell(
      onTap: () {
        //? update current product
        homeNotifier
          ..setCurrentProduct(
            homeState.categories[categoryIndex].products[productIndex],
            productIndex,
          )
          ..setCurrentCategory(
            homeState.categories[categoryIndex],
            categoryIndex,
          );
        //? go to book details page
        context.push(AppRouteNamed.bookDetailsPage.path);
      },
      borderRadius: BorderRadius.circular(4.r),
      child: Ink(
        width: 210.w,
        decoration: BoxDecoration(
          color: AppColors.greyColor,
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(10.w),
          child: Row(
            children: [
              //? book cover
              Container(
                width: 80.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Image.memory(
                  width: 80.w,
                  homeState
                      .categories[categoryIndex].products[productIndex].image,
                ),
              ),
              SizedBox(width: 10.w),
              //? book infos
              SizedBox(
                width: 100.w,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //? name
                      Text(
                        homeState.categories[categoryIndex]
                            .products[productIndex].name,
                        style: GoogleFonts.manrope(
                          textStyle: TextStyle(
                            color: AppColors.blackColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      //? author
                      Text(
                        homeState.categories[categoryIndex]
                            .products[productIndex].author,
                        style: GoogleFonts.manrope(
                          textStyle: TextStyle(
                            color: AppColors.black60,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const Spacer(),
                      //? price
                      Text(
                        homeState.categories[categoryIndex]
                            .products[productIndex].price
                            .toString()
                            .dollar,
                        style: GoogleFonts.manrope(
                          textStyle: TextStyle(
                            color: AppColors.purpleColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
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
