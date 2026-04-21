import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahl_shop/core/utils/app_colors.dart';
import 'package:sahl_shop/ui/ui/pages/home_screen/cubit/home_screen_view_model.dart';

import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_routes.dart';
import '../../../../core/utils/app_styles.dart';
import '../../widgets/custom_text_form_field.dart';

class HomeScreen extends StatelessWidget {
  static  String routeName = AppRoutes.homeRoute;


HomeScreenViewModel viewModel = HomeScreenViewModel();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: viewModel,
        builder: (context ,state){
        return  Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.whiteColor,
            elevation: 0,
            title: Text(
              "Sahl Shop",
              style: AppStyles.semi20Primary,
            ),

          ),
          body:Padding(
            padding:  EdgeInsets.symmetric(horizontal: 10.w),
            child: viewModel.bodyList[viewModel.selectedIndex],
          ),
          bottomNavigationBar: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.r),
              topRight: Radius.circular(16.r),
            ), // BorderRadius.only
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
                    selectedIcon: AppAssets.selectedFavouriteIcon,
                    unselectedIcon: AppAssets.unSelectedAccountIcon,
                  ),
                ],
              ),
            ),
          ),

        );
      }
    );
  }

  BottomNavigationBarItem _bottomNavBarItemBuilder({
    required bool isSelected,
    required String selectedIcon,
    required String unselectedIcon,
  }) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding:  EdgeInsets.only(top: 10),
        child: CircleAvatar(
          foregroundColor: isSelected ? AppColors.primaryColor : AppColors.whiteColor,
          backgroundColor: isSelected ? AppColors.whiteColor : Colors.transparent,
          radius: 30.r,
          child: Image.asset(
            isSelected ? selectedIcon : unselectedIcon,
          ), // Image.asset
        ),
      ), // CircleAvatar
      label: "",
    );
  }
}
