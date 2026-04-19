import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahl_shop/ui/ui/widgets/category_brand_item.dart';

import '../../../../../../core/utils/app_assets.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_styles.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
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
      _buildCategoryBrandSec(CategoryBrandItem()),




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
  SizedBox _buildCategoryBrandSec(Widget categoryBrand) {
    return SizedBox(
      height: 250.h,
      width: double.infinity,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 16.h,
          crossAxisSpacing: 16.w,
        ),
        itemCount: 21,
        scrollDirection: Axis.horizontal,
        physics: const ScrollPhysics(),
        itemBuilder: (context, index) {
          return categoryBrand;
        },
      ), // GridView.builder
    ); // SizedBox
  }
}
