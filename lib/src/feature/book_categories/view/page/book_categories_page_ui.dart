import 'package:ecommerce_case_study/src/core/extentions/string_extentions.dart';
import 'package:ecommerce_case_study/src/core/locator/providers.dart';
import 'package:ecommerce_case_study/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/enums.dart';
import '../../../../core/init/localization/locale_keys.g.dart';
import '../../../../core/theme/system_theme.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../mixin/book_categories_page_mixin.dart';

class BookCategoriesPageUi extends ConsumerStatefulWidget {
  const BookCategoriesPageUi({super.key});

  @override
  ConsumerState<BookCategoriesPageUi> createState() =>
      _BookCategoriesPageUiState();
}

class _BookCategoriesPageUiState extends ConsumerState<BookCategoriesPageUi>
    with BookCategoriesPageMixin<BookCategoriesPageUi> {
  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeProvider);
    final catgoriesNotifier = ref.read(bookCategoriesProvider.notifier);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemTheme.systemPanelColors(
        screen: SystemThemeScreenEnum.general,
      ),
      child: SafeArea(
        child: PopScope(
          onPopInvokedWithResult: (bool didPop, Object? result) {
            if (didPop) {
              catgoriesNotifier.clearSearch();
              return;
            }
          },
          child: Scaffold(
            backgroundColor: AppColors.whiteColor,
            appBar: CustomAppbar(
              title: CatalogButtons
                  .values[homeState.currentCategoryIndex! + 1].name,
              showBackButton: true,
              onBackPressed: () {
                //? search cleaning
                catgoriesNotifier.clearSearch();
                context.pop();
              },
            ),
            body: homeState.isSubmitting ||
                    homeState.categories.isEmpty ||
                    homeState.currentCategory == null
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
                    ),
                    child: NestedScrollView(
                      headerSliverBuilder: (context, innerBoxIsScrolled) => [
                        SliverToBoxAdapter(
                          child: Column(
                            children: [
                              //? Search field
                              TextFieldWidget(
                                hintText: LocaleKeys.searchHintText.locale,
                                textController: searchController,
                              ),
                            ],
                          ),
                        ),
                      ],
                      body: const ProductGridListWidget(),
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
    final homeState = ref.watch(homeProvider);
    final categoriesNotifier = ref.read(bookCategoriesProvider.notifier);
    return Padding(
      padding: EdgeInsets.only(bottom: 40.h, top: 30.h),
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
          onChanged: (value) {
            //? search proccess
            categoriesNotifier.searchController(
              value,
              homeState.currentCategory!,
            );
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

class ProductGridListWidget extends ConsumerWidget {
  const ProductGridListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeProvider);
    final categoriesState = ref.watch(bookCategoriesProvider);
    return SizedBox(
      height: 580.h,
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: categoriesState.isEmpty
            ? homeState.currentCategory!.products.length
            : categoriesState.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: 260.h,
          crossAxisCount: 2,
          crossAxisSpacing: 10.r,
          mainAxisSpacing: 10.r,
        ),
        itemBuilder: (BuildContext context, int index) {
          return ProductWidget(productIndex: index);
        },
      ),
    );
  }
}

class ProductWidget extends ConsumerWidget {
  final int productIndex;
  const ProductWidget({
    super.key,
    required this.productIndex,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeProvider);
    final homeNotifier = ref.read(homeProvider.notifier);
    final categoriesState = ref.watch(bookCategoriesProvider);
    return InkWell(
      onTap: () {
        //? update current product
        homeNotifier.setCurrentProduct(
          categoriesState.isEmpty
              ? homeState.currentCategory!.products[productIndex]
              : categoriesState[productIndex],
        );
        //Todo: go to home page
      },
      borderRadius: BorderRadius.circular(4.r),
      child: Ink(
        decoration: BoxDecoration(
          color: AppColors.greyColor,
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5.r),
          child: Column(
            children: [
              //? image
              Container(
                height: 210.h,
                width: 160.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.r),
                ),
                //Todo: image kontrol edilecek!
                child: Image.network(
                  fit: BoxFit.fill,
                  categoriesState.isEmpty
                      ? homeState.currentCategory!.products[productIndex].url
                      : categoriesState[productIndex].url,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 210.h,
                      width: 160.w,
                      decoration: BoxDecoration(
                        color: AppColors.purpleColor,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    );
                  },
                ),
              ),
              //? name
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Column(
                  children: [
                    //? Book name
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        categoriesState.isEmpty
                            ? homeState
                                .currentCategory!.products[productIndex].name
                            : categoriesState[productIndex].name,
                        style: GoogleFonts.manrope(
                          textStyle: TextStyle(
                            color: AppColors.blackColor,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    //? author - price row
                    Row(
                      children: [
                        //? Author name
                        SizedBox(
                          width: 70.w,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              categoriesState.isEmpty
                                  ? homeState.currentCategory!
                                      .products[productIndex].author
                                  : categoriesState[productIndex].author,
                              style: GoogleFonts.manrope(
                                textStyle: TextStyle(
                                  color: AppColors.black60,
                                  fontSize: 9.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        const Spacer(),
                        //? book price
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            categoriesState.isEmpty
                                ? homeState.currentCategory!
                                    .products[productIndex].price
                                    .toString()
                                    .dollar
                                : categoriesState[productIndex]
                                    .price
                                    .toString()
                                    .dollar,
                            style: GoogleFonts.manrope(
                              textStyle: TextStyle(
                                color: AppColors.purpleColor,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

