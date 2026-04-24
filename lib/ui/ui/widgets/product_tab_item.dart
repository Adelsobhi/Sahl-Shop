import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahl_shop/core/utils/app_styles.dart';

import '../../../core/utils/app_colors.dart';
import '../../../domain/entities/ProductResponseEntity.dart';
import 'custom_txt.dart';

class ProductTabItem extends StatelessWidget {
ProductsEntity product;
ProductTabItem({required this.product});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.primaryColor,
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15.r),
                child: CachedNetworkImage(
                  width: 191.w,
                  height: 120.h,
                  fit: BoxFit.cover,
                  imageUrl: product.thumbnail??'',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryDark,
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              Positioned(
                top: 8.h,
                right: 8.w,
                child: CircleAvatar(
                  backgroundColor: AppColors.whiteColor,
                  radius: 20.r,
                  child: Center(
                    child: IconButton(
                      onPressed: () {
                        // todo: add to favorite
                      },
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      iconSize: 30.r,
                      color: AppColors.primaryColor,
                      icon: const Icon(
                        Icons.favorite_border_rounded,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomTxt(
                  text:product.title??'',
                  textStyle:AppStyles.medium10Primary,
                ),
                SizedBox(
                  height: 1.h,
                ),


                SingleChildScrollView(
                  child: Row(
                    children: [
                     Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: CustomTxt(
                            text: "EGP ${product.price}",
                            textStyle: AppStyles.medium10White,
                            maxLines: 1,
                          ),
                        ),

                      SizedBox(width: 3.w),

                      Flexible(
                        child: CustomTxt(
                          text: "EGP ${product.discountPercentage}",
                          textStyle: AppStyles.medium8Primary.copyWith(
                            decoration: TextDecoration.lineThrough,
                            decorationColor: Colors.red,
                          ),
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                    Row(children: [
                      CustomTxt(
                        text: "Review (${product.rating})",
                        textStyle:AppStyles.medium10Primary,
                      ),
                      Icon(Icons.star,
                        color: AppColors.yellowColor,
                        size: 25.sp,),
                      const Spacer(
                        flex: 1,
                      ),

                    ],),
                SizedBox(
                  height:3.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  InkWell(
                    onTap: () {
                      // todo: add to cart
                    },
                    splashColor: AppColors.transparentColor,
                    child: Icon(
                      Icons.add_circle,
                      size: 47.sp,
                      color: AppColors.primaryColor,
                    ),
                  ),

                ],)



              ],
            ),
          )

        ],
      ),
    );
  }
}