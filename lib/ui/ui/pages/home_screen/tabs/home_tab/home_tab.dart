import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:sahl_shop/core/di/di.dart';
import 'package:sahl_shop/domain/entities/CategoryOrBrandResponseEntity.dart';
import 'package:sahl_shop/ui/ui/pages/home_screen/tabs/home_tab/cubit/home_tab_states.dart';
import 'package:sahl_shop/ui/ui/pages/home_screen/tabs/home_tab/cubit/home_tab_view_model.dart';
import 'package:sahl_shop/ui/ui/widgets/category_brand_item.dart';

import '../../../../../../core/utils/app_assets.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_styles.dart';

class HomeTab extends StatefulWidget {
  @override
  State<HomeTab> createState() => _HomeTabState();

}

class _HomeTabState extends State<HomeTab> {
  HomeTabViewModel viewModel = getIt< HomeTabViewModel>();
  @override
  void initState() {
    super.initState();
    viewModel.getAllCategories();
    viewModel.getAllBrands();
  }
  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      SizedBox(
        height: 16.h,
      ),
      _buildSlideShow(images: [
        AppAssets.img1SlideShow,
        AppAssets.img2SlideShow,
        AppAssets.img3SlideShow,
        AppAssets.img4SlideShow

      ]),
      SizedBox(
        height: 24.h,
      ),
      _buildNameCategory(name:'Categories'),

      BlocBuilder<HomeTabViewModel,HomeTabStates>(
        bloc: viewModel,
        buildWhen: (previous, current) =>
        current is CategorySuccessState || current is CategoryLoadingState || current is CategoryErrorState,
        builder: ( context,  state) {
            if(state is CategoryLoadingState){

              return Center(child: CircularProgressIndicator(color: AppColors.primaryColor,));
            }
             else if(state is CategoryErrorState){
              return Center(child: Text(state.errors.errorMessage));
            }
             else if(state is CategorySuccessState){
              return
                _buildCategoryBrandSec(state.responseEntity.data!);

          }
            return Container();
          },),
        SizedBox(
          height: 24.h,
        ),
        _buildNameCategory(name:'Brands'),
        BlocBuilder<HomeTabViewModel,HomeTabStates>(
          bloc: viewModel,
          buildWhen: (previous, current) =>
          current is BrandSuccessState || current is BrandLoadingState || current is BrandErrorState,
          builder: ( context,  state) {
            if(state is BrandLoadingState){
              return Center(child: CircularProgressIndicator(color: AppColors.primaryColor,));
            }
            else if(state is BrandErrorState){
              return Center(child: Text(state.errors.errorMessage));
            }
            else if(state is BrandSuccessState){
              return _buildCategoryBrandSec(state.responseEntity.data!);

            }
            return Container();
          },),






      ],));
  }


  ImageSlideshow _buildSlideShow({required List<String> images,}) {
    return ImageSlideshow(
      indicatorColor: AppColors.primaryColor,
      initialPage: 0,
      indicatorBottomPadding: 15.h,
      indicatorPadding: 8.w,
      indicatorRadius: 5,
      indicatorBackgroundColor: AppColors.whiteColor,
      isLoop: true,
      autoPlayInterval: 3000,
      height: 190.h,
      children: images.map((url) {
        return Image.asset(
          // هنا يتم تكملة الكود بناءً على ملفاتك
          url,
          fit: BoxFit.cover,
        );
      }).toList(),
    );}
  Widget _buildNameCategory({required String name}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
          style: AppStyles.medium14Header,
        ),
        TextButton(
          onPressed: () {
            // todo: navigate to all
          },
          child: Text(
            "View All",
            style: AppStyles.regular12Text, 
          ),
        ), // TextButton
      ],
    );
  }
  SizedBox _buildCategoryBrandSec(List<CategoryOrBrandEntity> categories) {
    return SizedBox(
      height: 250.h,
      width: double.infinity,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16.h,
          crossAxisSpacing: 16.w,
        ),
        itemCount: categories.length,
        scrollDirection: Axis.horizontal,
        physics: const ScrollPhysics(),
        itemBuilder: (context, index) {
          return CategoryBrandItem(item:categories[index] ,);
        },
      ), // GridView.builder
    ); // SizedBox
  }
}
