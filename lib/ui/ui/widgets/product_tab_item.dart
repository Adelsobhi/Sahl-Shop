 import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_styles.dart';
import '../../../domain/entities/ProductResponseEntity.dart';
import '../pages/home_screen/tabs/products_tab/cubit/products_tab_view_model.dart';
import 'custom_txt.dart';

class ProductTabItem extends StatefulWidget {
final DataEntity product;

const ProductTabItem({super.key, required this.product});

  @override
  State<ProductTabItem> createState() => _ProductTabItemState();
}

class _ProductTabItemState extends State<ProductTabItem> {
@override
Widget build(BuildContext context) {
final viewModel = ProductsTabViewModel.get(context);

final isFav = viewModel.favoriteIds.contains(widget.product.id);

return Container(
decoration: BoxDecoration(
borderRadius: BorderRadius.circular(16.r),
border: Border.all(
color: AppColors.primaryColor,
width: 1,
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
imageUrl: widget.product.imageCover ?? '',
placeholder: (context, url) => Center(
child: CircularProgressIndicator(
color: AppColors.primaryDark,
),
),
errorWidget: (context, url, error) =>
const Icon(Icons.error),
),
),

// ❤️ Favorite Button
Positioned(
top: 8.h,
right: 8.w,
child: CircleAvatar(
backgroundColor: AppColors.whiteColor,
radius: 20.r,
child: IconButton(
onPressed: () {
viewModel.toggleFavorite(productId: widget.product.id!);
setState(() {

});
},
padding: EdgeInsets.zero,
constraints: const BoxConstraints(),
iconSize: 28.sp,
icon: Icon(
isFav
? Icons.favorite
    : Icons.favorite_border_rounded,
color: isFav
? Colors.red
    : AppColors.primaryColor,
),
),
),
),
],
),

Padding(
padding: EdgeInsets.symmetric(
horizontal: 5.w,
vertical: 5.h,
),
child: Column(
children: [
CustomTxt(
text: widget.product.title ?? '',
textStyle: AppStyles.medium10Primary,
),

SizedBox(height: 3.h),

SingleChildScrollView(
  child: Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
  Container(
  padding: EdgeInsets.symmetric(
  horizontal: 8.w,
  vertical: 4.h,
  ),
  decoration: BoxDecoration(
  color: AppColors.primaryColor,
  borderRadius: BorderRadius.circular(8.r),
  ),
  child: CustomTxt(
  text: "EGP ${widget.product.price}",
  textStyle: AppStyles.medium10White.copyWith(fontSize: 8),
  ),
  ),

  SizedBox(width: 4.w),

  CustomTxt(
  text: "EGP ${widget.product.price! * 1.3.toInt()}",
   textStyle: AppStyles.medium8Primary.copyWith(
     fontSize: 6,
  decoration: TextDecoration.lineThrough,
  decorationColor: Colors.red,
  ),
  ),
  ],
  ),
),

SizedBox(height: 3.h),

Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
CustomTxt(
text:
"Review ${widget.product.ratingsAverage} (${widget.product.ratingsQuantity})",
textStyle: AppStyles.medium10Primary,
),
Icon(
Icons.star,
color: AppColors.yellowColor,
size: 20.sp,
),
],
),

SizedBox(height: 5.h),

Row(
mainAxisAlignment: MainAxisAlignment.center,
children: [
InkWell(
onTap: () {
viewModel.addToCart(productId: widget.product.id!);
},
child: Icon(
Icons.add_circle,
size: 45.sp,
color: AppColors.primaryColor,
),
),
],
),
],
),
),
],
),
);
}
}






























// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:sahl_shop/core/utils/app_styles.dart';
//
// import '../../../core/utils/app_colors.dart';
// import '../../../domain/entities/ProductResponseEntity.dart';
// import '../pages/home_screen/tabs/products_tab/cubit/products_tab_view_model.dart';
// import 'custom_txt.dart';
//
// class ProductTabItem extends StatelessWidget {
// DataEntity product;
//
// ProductTabItem({required this.product});
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(16.r),
//         border: Border.all(
//           color: AppColors.primaryColor,
//           width: 1,
//         ),
//       ),
//       child: Column(
//         children: [
//           Stack(
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(15.r),
//                 child: CachedNetworkImage(
//                   width: 191.w,
//                   height: 120.h,
//                   fit: BoxFit.cover,
//                   imageUrl: product.imageCover??'',
//                   placeholder: (context, url) => Center(
//                     child: CircularProgressIndicator(
//                       color: AppColors.primaryDark,
//                     ),
//                   ),
//                   errorWidget: (context, url, error) => const Icon(Icons.error),
//                 ),
//               ),
//               Positioned(
//                 top: 8.h,
//                 right: 8.w,
//                 child: CircleAvatar(
//                   backgroundColor: AppColors.whiteColor,
//                   radius: 20.r,
//                   child: Center(
//                     child: IconButton(
//                       onPressed: () {
//
//
//                       },
//                       padding: EdgeInsets.zero,
//                       constraints: const BoxConstraints(),
//                       iconSize: 30.r,
//                       color: AppColors.primaryColor,
//                       icon: const Icon(
//                         Icons.favorite_border_rounded,
//                       ),
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 CustomTxt(
//                   text:product.title??'',
//                   textStyle:AppStyles.medium10Primary,
//                 ),
//                 SizedBox(
//                   height: 1.h,
//                 ),
//
//
//                 SingleChildScrollView(
//                   child: Row(
//
//                     mainAxisSize: MainAxisSize.min,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.center,
//
//                     children: [
//                      Container(
//                           padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
//                           decoration: BoxDecoration(
//                             color: AppColors.primaryColor,
//                             borderRadius: BorderRadius.circular(8.r),
//                           ),
//                           child: CustomTxt(
//                             text: "EGP ${product.price}",
//                             textStyle: AppStyles.medium10White,
//                             maxLines: 1,
//                           ),
//                         ),
//
//
//                       SizedBox(width: 8.w),
//
//                       Flexible(
//                         child: CustomTxt(
//                           text: "EGP ${product.price!*1.5}",
//                           textStyle: AppStyles.medium8Primary.copyWith(
//                             decoration: TextDecoration.lineThrough,
//                             decorationColor: Colors.red,
//                           ),
//                           maxLines: 1,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: 1.h,
//                 ),
//                     Row(children: [
//                       CustomTxt(
//                         text: "Review ${product.ratingsAverage}( ${product.ratingsQuantity} )",
//                         textStyle:AppStyles.medium10Primary,
//                       ),
//                       Icon(Icons.star,
//                         color: AppColors.yellowColor,
//                         size: 25.sp,),
//                       const Spacer(
//                         flex: 1,
//                       ),
//
//                     ],),
//                 SizedBox(
//                   height:3.h,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                   InkWell(
//                     onTap: () {
//                       ProductsTabViewModel.get(context).addToCart(productId:product.id!);
//
//                     },
//                     splashColor: AppColors.transparentColor,
//                     child: Icon(
//                       Icons.add_circle,
//                       size: 47.sp,
//                       color: AppColors.primaryColor,
//                     ),
//                   ),
//
//                 ],)
//
//
//
//               ],
//             ),
//           )
//
//         ],
//       ),
//     );
//   }
// }