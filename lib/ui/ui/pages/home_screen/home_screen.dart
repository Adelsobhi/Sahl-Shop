











import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahl_shop/core/utils/app_colors.dart';
import 'package:sahl_shop/ui/ui/pages/cart_screen/cart_screen.dart';
import 'package:sahl_shop/ui/ui/pages/home_screen/cubit/home_screen_view_model.dart';
import 'package:sahl_shop/ui/ui/pages/home_screen/tabs/products_tab/cubit/products_tab_states.dart';
import 'package:sahl_shop/ui/ui/pages/home_screen/tabs/products_tab/cubit/products_tab_view_model.dart';

import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_routes.dart';
import '../../../../core/utils/app_styles.dart';
import '../../widgets/custom_text_form_field.dart';
import 'cubit/home_screen_states.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = AppRoutes.homeRoute;

  final HomeScreenViewModel viewModel = HomeScreenViewModel();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenViewModel, HomeScreenStates>(
        bloc: viewModel,
        builder: (context, state) {
          return Scaffold(
            appBar: _buildAppBar(viewModel.selectedIndex, context),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: viewModel.bodyList[viewModel.selectedIndex],
            ),
            bottomNavigationBar: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
              ),
              child: Theme(
                data: Theme.of(context).copyWith(canvasColor: AppColors.primaryColor),
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  elevation: 0,
                  currentIndex: viewModel.selectedIndex,
                  onTap: viewModel.changeIndex,
                  iconSize: 24.sp,
                  items: [
                    _bottomNavBarItemBuilder(
                      isSelected: viewModel.selectedIndex == 0,
                      selectedIcon: AppAssets.selectedHomeIcon,
                      unselectedIcon: AppAssets.unSelectedHomeIcon,
                    ),
                    _bottomNavBarItemBuilder(
                      isSelected: viewModel.selectedIndex == 1,
                      selectedIcon: AppAssets.selectedCategoryIcon,
                      unselectedIcon: AppAssets.unSelectedCategoryIcon,
                    ),
                    _bottomNavBarItemBuilder(
                      isSelected: viewModel.selectedIndex == 2,
                      selectedIcon: AppAssets.selectedFavouriteIcon,
                      unselectedIcon: AppAssets.unSelectedFavouriteIcon,
                    ),
                    _bottomNavBarItemBuilder(
                      isSelected: viewModel.selectedIndex == 3,
                      selectedIcon: AppAssets.selectedAccountIcon,
                      unselectedIcon: AppAssets.unSelectedAccountIcon,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  BottomNavigationBarItem _bottomNavBarItemBuilder({
    required bool isSelected,
    required String selectedIcon,
    required String unselectedIcon,
  }) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: EdgeInsets.only(top: 10.h),
        child: CircleAvatar(
          foregroundColor: isSelected ? AppColors.primaryColor : AppColors.whiteColor,
          backgroundColor: isSelected ? AppColors.whiteColor : Colors.transparent,
          radius: 25.r, // تقليل الحجم قليلاً ليتناسب مع التصميم
          child: Image.asset(
            isSelected ? selectedIcon : unselectedIcon,
            width: 25.w,
          ),
        ),
      ),
      label: "",
    );
  }

  PreferredSizeWidget _buildAppBar(int index, BuildContext context) {
    return AppBar(
      surfaceTintColor: AppColors.transparentColor,
      elevation: 0,
      toolbarHeight: index != 3 ? 150.h : 60.h, // تعديل الارتفاع في حالة البروفايل
      leadingWidth: double.infinity,
      leading: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 1.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
                visible: index != 3,
                child: Image.asset(AppAssets.logoApp, width: 100.w, height: 60.h)),
            Visibility(
              visible: index != 3,
              child: Row(
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      borderColor: AppColors.primaryColor,
                      filledColor: AppColors.transparentColor,
                      hintText: "what do you search for?",
                      prefixIcon: Icon(Icons.search, color: AppColors.primaryColor),
                      hintStyle: AppStyles.light12SearchHint,
                      textStyle: AppStyles.regular12Text,
                      // --- التعديل هنا: ربط البحث بالـ ViewModel ---
                      onChanged: (text) {
                        ProductsTabViewModel.get(context).search(text);
                        if (text.isNotEmpty && viewModel.selectedIndex == 0) {
                          viewModel.changeIndex(1);
                        }
                      },
                    ),
                  ),
                  SizedBox(width: 8.w),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(CartScreen.routeName);
                    },
                    child: BlocBuilder<ProductsTabViewModel, ProductsTabStates>(
                      builder: (context, state) {
                        var prodViewModel = ProductsTabViewModel.get(context);

                        return badges.Badge(
                          position: badges.BadgePosition.topEnd(top: -10, end: -5),
                          showBadge: (prodViewModel.numOfCartItems ?? 0) > 0,
                          badgeAnimation: const badges.BadgeAnimation.scale(
                            animationDuration: Duration(milliseconds: 300),
                            loopAnimation: false,
                          ),
                          badgeStyle: badges.BadgeStyle(
                            shape: badges.BadgeShape.circle,
                            badgeColor: AppColors.greenColor,
                            padding: EdgeInsets.all(5.w),
                          ),
                          badgeContent: Text(
                            prodViewModel.numOfCartItems?.toString() ?? "0",
                            style: AppStyles.regular12Text.copyWith(
                              fontSize: 10.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          child: Icon(
                            Icons.shopping_cart_outlined,
                            size: 30.sp,
                            color: AppColors.primaryColor,
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}