import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahl_shop/core/utils/app_routes.dart';
import 'package:readmore/readmore.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../domain/entities/ProductResponseEntity.dart';
import '../../widgets/custom_txt.dart';

class ProductDetailsScreen extends StatefulWidget {
 static  String routeName = AppRoutes.productDetailsRoute;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int productCounter = 1;
  int selectedColor = -1;
  int selectedSize = -1;

  List<int> sizes = [35, 38, 39, 40];

  List<Color> color = [
    Colors.red,
    Colors.blueAccent,
    Colors.green,
    Colors.yellow,
  ];


  @override
  Widget build(BuildContext context) {
    var args= ModalRoute.of(context)?.settings.arguments as ProductsEntity;


    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Product Details",
          style: AppStyles.semi16Primary,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: AppColors.primaryColor,size: 30,),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart_outlined, color: AppColors.primaryColor,size: 30,),
          ),
          SizedBox(width: 10.w,),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 16.h,left: 16.w, right: 16.w, bottom: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            ImageSlideshow(
            indicatorColor: AppColors.primaryColor,
            initialPage: 0,
            indicatorBottomPadding: 15.h,
            indicatorPadding: 8.w,
            indicatorRadius: 5,
            indicatorBackgroundColor: AppColors.whiteColor,
            isLoop: true,
            autoPlayInterval: 3000,
            height: 190.h,
            children: args.images!.map((url) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(15.r),
                child: CachedNetworkImage(
                  width: double.infinity,
                  height: 120.h,
                  imageUrl: url,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.yellowColor,
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.error,
                    color: AppColors.redColor,
                  ),
                ),
              );
                }).toList()),
              SizedBox(height: 24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      args.title ?? "Title",
                      style: AppStyles.medium14Primary,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: CustomTxt(
                      text: "EGP ${args.price}",
                      textStyle: AppStyles.medium10White,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Row(
                children:
                [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                    decoration: BoxDecoration(
                      color: (args.stock ?? 0) < 10
                          ? Colors.red.withOpacity(0.1)
                          : Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(
                        color: AppColors.primaryColor,
                        width: 1.w,
                      ),
                
                    ),
                    child: Text(
                      "Available in stock: ${args.stock} piece",
                      style: AppStyles.medium8Primary,
                    ),


                    ),
                  SizedBox(width: 3.w),
                  Icon(
                    Icons.star,
                    color: AppColors.yellowColor,
                    size: 20.sp,
                  ),
                  SizedBox(width: 3.w),
                  Text(
                    "${args.rating}",
                    style: AppStyles.medium10Primary,
                  ),
                  SizedBox(width: 3.w),
                  Container(
                      child:Row(
                        children: [
                          Container(
                            height: 30.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(24.r),
                              border: Border.all(
                                color: AppColors.primaryColor,
                                width: 1,
                              ),

                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InkWell(
                                  onTap: () {
                                    if (productCounter > 1) {
                                      setState(() {
                                        productCounter--;
                                      });
                                    }
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                                    child: Icon(
                                      Icons.remove_circle_outline,
                                      color: AppColors.primaryColor,
                                      size: 22.sp,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    "$productCounter",
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                ),

                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      productCounter++;
                                    });
                                  },
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(24.r),
                                    bottomRight: Radius.circular(24.r),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                                    child: Icon(
                                      Icons.add_circle_outline,
                                      color: AppColors.primaryColor,
                                      size: 22.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                  )

                ],
              ),
              SizedBox(height: 16.h),
              Text(
                "Description",
                style: AppStyles.medium12Header ,
              ),
              SizedBox(height: 16.h),
          ReadMoreText(
            args.description ?? "Description",
            style: AppStyles.light10Primary,
            textAlign: TextAlign.start,
            trimMode: TrimMode.Line,
            trimLines: 2,
            colorClickableText: AppColors.primaryColor,

            trimCollapsedText: 'Show more',
            trimExpandedText: 'Show less',
            moreStyle: AppStyles.medium10Primary,
            lessStyle: AppStyles.medium10Primary,
          ),
              SizedBox(height: 16.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Size", style: AppStyles.medium12Header),
                  SizedBox(height: 8.h),
                  SizedBox(
                    height: 35.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: sizes.length,
                      itemBuilder: (context, index) {
                        bool isSelected = selectedSize == index;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedSize = index;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 16.w),
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: isSelected ? AppColors.primaryColor : Colors.transparent,
                              borderRadius: BorderRadius.circular(20.r),
                              border: Border.all(
                                color: isSelected ? AppColors.primaryColor : Colors.grey.shade300,
                              ),
                            ),
                            child: Text(
                              "${sizes[index]}",
                              style: AppStyles.medium12Header.copyWith(

                                    color: isSelected ? Colors.white : AppColors.primaryColor,
                                    fontWeight: FontWeight.bold,

                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Color", style: AppStyles.medium12Header),
                  SizedBox(height: 8.h),
                  SizedBox(
                    height: 35.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: color.length,
                      itemBuilder: (context, index) {
                        bool isSelected = selectedColor == index;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedColor = index;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 12.w),
                            width: 35.w,
                            height: 35.h,
                            decoration: BoxDecoration(
                              color: color[index],
                              shape: BoxShape.circle,
                              border: isSelected
                                  ? Border.all(color: AppColors.primaryColor, width: 2)
                                  : null,
                            ),
                            child: isSelected
                                ? Icon(Icons.check, color: Colors.white, size: 16.sp)
                                : null,
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 30.h),
                    Row(
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Total Price", style: AppStyles.medium12Header),
                            Text(
                              "EGP ${((args.price ?? 0) * productCounter).toStringAsFixed(2)}",
                              style: AppStyles.medium12Header),
                          ],
                        ),

                        SizedBox(width: 24.w),

                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              print("Added $productCounter items to cart");
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.r),
                              ),
                              elevation: 0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add_shopping_cart_outlined, color: Colors.white,size: 25.sp,),
                                SizedBox(width: 8.w),
                                Text(
                                  "Add to Cart",
                                  style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )

                ],
              )




            ],
          ),
        ),
      ),
    );
  }
}