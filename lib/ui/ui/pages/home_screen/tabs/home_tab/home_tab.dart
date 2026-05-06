 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahl_shop/core/di/di.dart';
import 'package:sahl_shop/domain/entities/CategoryOrBrandResponseEntity.dart';
import 'package:sahl_shop/ui/ui/pages/home_screen/tabs/home_tab/cubit/home_tab_states.dart';
import 'package:sahl_shop/ui/ui/pages/home_screen/tabs/home_tab/cubit/home_tab_view_model.dart';
import 'package:sahl_shop/ui/ui/widgets/category_item.dart';
import '../../../../../../core/utils/app_assets.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_routes.dart';
import '../../../../../../core/utils/app_styles.dart';
import '../../../../../../core/utils/flutter_toast.dart';

import '../../../../widgets/product_tab_item.dart';
import '../products_tab/cubit/products_tab_states.dart';
import '../products_tab/cubit/products_tab_view_model.dart';

class HomeTab extends StatefulWidget {
@override
State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
HomeTabViewModel viewModel = getIt<HomeTabViewModel>();
ProductsTabViewModel productsViewModel = getIt<ProductsTabViewModel>();

@override
void initState() {
super.initState();
viewModel.getAllCategories();
viewModel.getAllBrands();
productsViewModel.getAllProducts(); // 👈 هنا الصح
}

@override
Widget build(BuildContext context) {
return SingleChildScrollView(
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [

SizedBox(height: 16.h),

_buildSlideShow(images: [
AppAssets.img1SlideShow,
AppAssets.img2SlideShow,
AppAssets.img3SlideShow,
AppAssets.img4SlideShow
]),

SizedBox(height: 24.h),

  _buildSectionTitle('Categories'),

BlocBuilder<HomeTabViewModel, HomeTabStates>(
bloc: viewModel,
buildWhen: (previous, current) =>
current is CategorySuccessState ||
current is CategoryLoadingState ||
current is CategoryErrorState,
builder: (context, state) {
if (state is CategoryLoadingState) {
return Center(
child: CircularProgressIndicator(
color: AppColors.primaryColor));
}

if (state is CategoryErrorState) {
return Center(child: Text(state.errors.errorMessage));
}

if (state is CategorySuccessState) {
return _buildCategorySec(state.responseEntity.data!);
}

return Container();
},
),

SizedBox(height: 24.h),

  _buildSectionTitle('Brands'),


BlocBuilder<HomeTabViewModel, HomeTabStates>(
bloc: viewModel,
buildWhen: (previous, current) =>
current is BrandSuccessState ||
current is BrandLoadingState ||
current is BrandErrorState,
builder: (context, state) {
if (state is BrandLoadingState) {
return Center(
child: CircularProgressIndicator(
color: AppColors.primaryColor));
}

if (state is BrandErrorState) {
return Center(child: Text(state.errors.errorMessage));
}

if (state is BrandSuccessState) {
return _buildBrandSec(state.responseEntity.data!);
}

return Container();
},
),

SizedBox(height: 24.h),

  _buildSectionTitle('Important Products'),


_buildProductsSection(),

SizedBox(height: 20.h),
],
),
);
}
 // ================= SLIDER =================
ImageSlideshow _buildSlideShow({required List<String> images}) {
return ImageSlideshow(
indicatorColor: AppColors.primaryColor,
isLoop: true,
autoPlayInterval: 3000,
height: 190.h,
children: images
    .map((url) => Image.asset(url, fit: BoxFit.cover))
    .toList(),
);
}

  // ================= TITLE =================
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        children: [
          Container(
            width: 5.w,
            height: 18.h,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
          SizedBox(width: 8.w),
          Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }

// ================= CATEGORIES =================
  SizedBox _buildCategorySec(List<CategoryOrBrandEntity> categories) {
    return SizedBox(
      height: 180.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        itemCount: categories.length,
        separatorBuilder: (context, index) => SizedBox(width: 12.w),
        itemBuilder: (context, index) {
          return SizedBox(
            width: 120.w,
            child: CategoryItem(item: categories[index]),
          );
        },
      ),
    );
  }
  // ================= BRANDS =================
  SizedBox _buildBrandSec(List<CategoryOrBrandEntity> brands) {
    return SizedBox(
      height: 200.h,
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: brands.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12.w,
          crossAxisSpacing: 12.h,
          childAspectRatio: 1.1,
        ),
        itemBuilder: (context, index) {
          return Material(
            color: Colors.transparent,
            child: CategoryItem(item: brands[index]),
          );
        },
      ),
    );
  }
// ================= PRODUCTS =================
  Widget _buildProductsSection() {
    return BlocListener<ProductsTabViewModel, ProductsTabStates>(
      listener: (context, state) {
        if (state is AddCartSuccessState) {
          ToastMessage.toastMsg(
            msg: 'Product added successfully',
            backgroundColor: AppColors.greenColor,
            textColor: AppColors.whiteColor,
          );
        }

        if (state is AddCartErrorState) {
          ToastMessage.toastMsg(
            msg: state.errorMessage.errorMessage,
            backgroundColor: AppColors.redColor,
            textColor: AppColors.whiteColor,
          );
        }
      },
      listenWhen: (previous, current) =>
      current is AddCartSuccessState ||
          current is AddCartErrorState,
      child: BlocBuilder<ProductsTabViewModel, ProductsTabStates>(
        bloc: productsViewModel,
        builder: (context, state) {

          /// LOADING UI (modern skeleton feel)
          if (state is ProductTabLoadingState) {
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 4,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65,
                crossAxisSpacing: 14.w,
                mainAxisSpacing: 14.h,
              ),
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                );
              },
            );
          }

          final products = productsViewModel.productsList;

          /// ERROR
          if (state is ProductTabErrorState) {
            return Center(
              child: Text(
                state.errorMessage.errorMessage,
                style: TextStyle(color: Colors.red),
              ),
            );
          }

          /// EMPTY STATE
          if (products == null || products.isEmpty) {
            return Center(
              child: Column(
                children: [
                  Icon(Icons.shopping_bag_outlined,
                      size: 60, color: Colors.grey),
                  SizedBox(height: 10),
                  Text("No products found"),
                ],
              ),
            );
          }

          /// SUCCESS GRID
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            itemCount: products.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.62,
              crossAxisSpacing: 14.w,
              mainAxisSpacing: 14.h,
            ),
            itemBuilder: (context, index) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: InkWell(
                  borderRadius: BorderRadius.circular(16.r),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.productDetailsRoute,
                      arguments: products[index],
                    );
                  },
                  child: ProductTabItem(product: products[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }}
















 //
 //
 // import 'package:flutter/material.dart';
 // import 'package:flutter_bloc/flutter_bloc.dart';
 // import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
 // import 'package:flutter_screenutil/flutter_screenutil.dart';
 // import 'package:sahl_shop/core/di/di.dart';
 // import 'package:sahl_shop/core/utils/app_assets.dart';
 // import 'package:sahl_shop/core/utils/app_colors.dart';
 // import 'package:sahl_shop/core/utils/app_routes.dart';
 // import 'package:sahl_shop/core/utils/app_styles.dart';
 // import 'package:sahl_shop/core/utils/flutter_toast.dart';
 //
 // import 'package:sahl_shop/ui/ui/pages/home_screen/tabs/home_tab/cubit/home_tab_states.dart';
 // import 'package:sahl_shop/ui/ui/pages/home_screen/tabs/home_tab/cubit/home_tab_view_model.dart';
 // import 'package:sahl_shop/ui/ui/pages/home_screen/tabs/products_tab/cubit/products_tab_states.dart';
 // import 'package:sahl_shop/ui/ui/pages/home_screen/tabs/products_tab/cubit/products_tab_view_model.dart';
 //
 // import '../../../../../../domain/entities/CategoryOrBrandResponseEntity.dart';
 // import '../../../../widgets/category_item.dart';
 // import '../../../../widgets/product_tab_item.dart';
 //
 // class HomeTab extends StatefulWidget {
 //   @override
 //   State<HomeTab> createState() => _HomeTabState();
 // }
 //
 // class _HomeTabState extends State<HomeTab> {
 //   HomeTabViewModel viewModel = getIt<HomeTabViewModel>();
 //   ProductsTabViewModel productsViewModel = getIt<ProductsTabViewModel>();
 //
 //   @override
 //   void initState() {
 //     super.initState();
 //     viewModel.getAllCategories();
 //     viewModel.getAllBrands();
 //     productsViewModel.getAllProducts();
 //   }
 //
 //   @override
 //   Widget build(BuildContext context) {
 //     return SingleChildScrollView(
 //       physics: const BouncingScrollPhysics(),
 //       child: Padding(
 //         padding: EdgeInsets.symmetric(horizontal: 12.w),
 //         child: Column(
 //           crossAxisAlignment: CrossAxisAlignment.start,
 //           children: [
 //             SizedBox(height: 12.h),
 //
 //             /// ================= SLIDER =================
 //             _buildSlideShow(images: [
 //               AppAssets.img1SlideShow,
 //               AppAssets.img2SlideShow,
 //               AppAssets.img3SlideShow,
 //               AppAssets.img4SlideShow,
 //             ]),
 //
 //             SizedBox(height: 20.h),
 //
 //             /// ================= CATEGORIES =================
 //             _buildSectionTitle("Categories"),
 //
 //             BlocBuilder<HomeTabViewModel, HomeTabStates>(
 //               bloc: viewModel,
 //               buildWhen: (previous, current) =>
 //               current is BrandSuccessState ||
 //                   current is BrandLoadingState ||
 //                   current is BrandErrorState,
 //               builder: (context, state) {
 //                 if (state is CategoryLoadingState) {
 //                   return _loading();
 //                 }
 //
 //                 if (state is CategorySuccessState) {
 //                   return _buildCategorySec(state.responseEntity.data!);
 //                 }
 //
 //                 if (state is CategoryErrorState) {
 //                   return Center(child: Text(state.errors.errorMessage));
 //                 }
 //
 //                 return const SizedBox();
 //               },
 //             ),
 //
 //             SizedBox(height: 20.h),
 //
 //             /// ================= BRANDS =================
 //             _buildSectionTitle("Brands"),
 //
 //             BlocBuilder<HomeTabViewModel, HomeTabStates>(
 //               bloc: viewModel,
 //               builder: (context, state) {
 //                 if (state is BrandLoadingState) {
 //                   return _loading();
 //                 }
 //
 //                 if (state is BrandSuccessState) {
 //                   return _buildBrandSec(state.responseEntity.data!);
 //                 }
 //
 //                 if (state is BrandErrorState) {
 //                   return Center(child: Text(state.errors.errorMessage));
 //                 }
 //
 //                 return const SizedBox();
 //               },
 //             ),
 //
 //             SizedBox(height: 20.h),
 //
 //             /// ================= PRODUCTS =================
 //             _buildSectionTitle("Trending Products"),
 //
 //             _buildProductsSection(),
 //
 //             SizedBox(height: 20.h),
 //           ],
 //         ),
 //       ),
 //     );
 //   }
 //
 //   // ================= SLIDER =================
 //   Widget _buildSlideShow({required List<String> images}) {
 //     return ClipRRect(
 //       borderRadius: BorderRadius.circular(16.r),
 //       child: ImageSlideshow(
 //         indicatorColor: AppColors.primaryColor,
 //         isLoop: true,
 //         autoPlayInterval: 3000,
 //         height: 200.h,
 //         children: images
 //             .map((url) => Image.asset(url, fit: BoxFit.cover))
 //             .toList(),
 //       ),
 //     );
 //   }
 //
 //   // ================= TITLE =================
 //   Widget _buildSectionTitle(String title) {
 //     return Padding(
 //       padding: EdgeInsets.symmetric(vertical: 12.h),
 //       child: Row(
 //         children: [
 //           Container(
 //             width: 5.w,
 //             height: 18.h,
 //             decoration: BoxDecoration(
 //               color: AppColors.primaryColor,
 //               borderRadius: BorderRadius.circular(10.r),
 //             ),
 //           ),
 //           SizedBox(width: 8.w),
 //           Text(
 //             title,
 //             style: TextStyle(
 //               fontSize: 16.sp,
 //               fontWeight: FontWeight.bold,
 //               color: AppColors.primaryColor,
 //             ),
 //           ),
 //         ],
 //       ),
 //     );
 //   }
 //
 //   // ================= CATEGORY =================
 //   Widget _buildCategorySec(List<CategoryOrBrandEntity> categories) {
 //     return SizedBox(
 //       height: 220.h,
 //       child: GridView.builder(
 //         scrollDirection: Axis.horizontal,
 //         physics: const BouncingScrollPhysics(),
 //         itemCount: categories.length,
 //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
 //           crossAxisCount: 2,
 //           mainAxisSpacing: 10.w,
 //           crossAxisSpacing: 10.h,
 //           childAspectRatio: 1,
 //         ),
 //         itemBuilder: (context, index) {
 //           return Container(
 //             decoration: BoxDecoration(
 //               color: Colors.white,
 //               borderRadius: BorderRadius.circular(16.r),
 //               boxShadow: [
 //                 BoxShadow(
 //                   color: Colors.black.withOpacity(0.05),
 //                   blurRadius: 10,
 //                 )
 //               ],
 //             ),
 //             child: CategoryItem(item: categories[index]),
 //           );
 //         },
 //       ),
 //     );
 //   }
 //
 //   // ================= BRANDS =================
 //   Widget _buildBrandSec(List<CategoryOrBrandEntity> brands) {
 //     return SizedBox(
 //       height: 220.h,
 //       child: GridView.builder(
 //         scrollDirection: Axis.horizontal,
 //         physics: const BouncingScrollPhysics(),
 //         itemCount: brands.length,
 //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
 //           crossAxisCount: 2,
 //           mainAxisSpacing: 10.w,
 //           crossAxisSpacing: 10.h,
 //           childAspectRatio: 1,
 //         ),
 //         itemBuilder: (context, index) {
 //           return Container(
 //             decoration: BoxDecoration(
 //               color: Colors.white,
 //               borderRadius: BorderRadius.circular(16.r),
 //               boxShadow: [
 //                 BoxShadow(
 //                   color: Colors.black.withOpacity(0.05),
 //                   blurRadius: 10,
 //                 )
 //               ],
 //             ),
 //             child: CategoryItem(item: brands[index]),
 //           );
 //         },
 //       ),
 //     );
 //   }
 //
 //   // ================= PRODUCTS =================
 //   Widget _buildProductsSection() {
 //     return BlocListener<ProductsTabViewModel, ProductsTabStates>(
 //       listener: (context, state) {
 //         if (state is AddCartSuccessState) {
 //           ToastMessage.toastMsg(
 //             msg: 'Added to cart',
 //             backgroundColor: AppColors.greenColor,
 //             textColor: AppColors.whiteColor,
 //           );
 //         }
 //
 //         if (state is AddCartErrorState) {
 //           ToastMessage.toastMsg(
 //             msg: state.errorMessage.errorMessage,
 //             backgroundColor: AppColors.redColor,
 //             textColor: AppColors.whiteColor,
 //           );
 //         }
 //       },
 //       child: BlocBuilder<ProductsTabViewModel, ProductsTabStates>(
 //         bloc: productsViewModel,
 //         builder: (context, state) {
 //           if (state is ProductTabLoadingState) {
 //             return _loading();
 //           }
 //
 //           final products = productsViewModel.productsList;
 //
 //           if (products == null || products.isEmpty) {
 //             return const SizedBox();
 //           }
 //
 //           return GridView.builder(
 //             shrinkWrap: true,
 //             physics: const NeverScrollableScrollPhysics(),
 //             itemCount: products.length,
 //             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
 //               crossAxisCount: 2,
 //               childAspectRatio: 0.68,
 //               crossAxisSpacing: 12.w,
 //               mainAxisSpacing: 12.h,
 //             ),
 //             itemBuilder: (context, index) {
 //               return GestureDetector(
 //                 onTap: () {
 //                   Navigator.pushNamed(
 //                     context,
 //                     AppRoutes.productDetailsRoute,
 //                     arguments: products[index],
 //                   );
 //                 },
 //                 child: Container(
 //                   decoration: BoxDecoration(
 //                     color: Colors.white,
 //                     borderRadius: BorderRadius.circular(18.r),
 //                     boxShadow: [
 //                       BoxShadow(
 //                         color: Colors.black.withOpacity(0.05),
 //                         blurRadius: 10,
 //                       )
 //                     ],
 //                   ),
 //                   child: ProductTabItem(product: products[index]),
 //                 ),
 //               );
 //             },
 //           );
 //         },
 //       ),
 //     );
 //   }
 //
 //   // ================= LOADING =================
 //   Widget _loading() {
 //     return Padding(
 //       padding: EdgeInsets.all(20.h),
 //       child: Center(
 //         child: CircularProgressIndicator(
 //           color: AppColors.primaryColor,
 //         ),
 //       ),
 //     );
 //   }
 // }














































// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:sahl_shop/core/di/di.dart';
// import 'package:sahl_shop/domain/entities/CategoryOrBrandResponseEntity.dart';
// import 'package:sahl_shop/ui/ui/pages/home_screen/tabs/home_tab/cubit/home_tab_states.dart';
// import 'package:sahl_shop/ui/ui/pages/home_screen/tabs/home_tab/cubit/home_tab_view_model.dart';
// import 'package:sahl_shop/ui/ui/widgets/category_item.dart';
//
// import '../../../../../../core/utils/app_assets.dart';
// import '../../../../../../core/utils/app_colors.dart';
// import '../../../../../../core/utils/app_styles.dart';
// import '../products_tab/cubit/products_tab_view_model.dart';
//
// class HomeTab extends StatefulWidget {
//   @override
//   State<HomeTab> createState() => _HomeTabState();
//
// }
//
// class _HomeTabState extends State<HomeTab> {
//   HomeTabViewModel viewModel = getIt< HomeTabViewModel>();
//   @override
//   void initState() {
//     super.initState();
//     viewModel.getAllCategories();
//     viewModel.getAllBrands();
//   }
//   @override
//   Widget build(BuildContext context) {
//     ProductsTabViewModel viewModelProducts= ProductsTabViewModel.get(context);
//
//     return  SingleChildScrollView(child: Column(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//       SizedBox(
//         height: 16.h,
//       ),
//       _buildSlideShow(images: [
//         AppAssets.img1SlideShow,
//         AppAssets.img2SlideShow,
//         AppAssets.img3SlideShow,
//         AppAssets.img4SlideShow
//
//       ]),
//       SizedBox(
//         height: 24.h,
//       ),
//       _buildNameCategory(name:'Categories'),
//       BlocBuilder<HomeTabViewModel,HomeTabStates>(
//         bloc: viewModel,
//         buildWhen: (previous, current) =>
//         current is CategorySuccessState || current is CategoryLoadingState || current is CategoryErrorState,
//         builder: ( context,  state) {
//             if(state is CategoryLoadingState){
//
//               return Center(child: CircularProgressIndicator(color: AppColors.primaryColor,));
//             }
//              else if(state is CategoryErrorState){
//               return Center(child: Text(state.errors.errorMessage));
//             }
//              else if(state is CategorySuccessState){
//               return
//                 _buildCategorySec(state.responseEntity.data!);
//
//           }
//             return Container();
//           },),
//         SizedBox(
//           height: 24.h,
//         ),
//         _buildNameCategory(name:'Brands'),
//         BlocBuilder<HomeTabViewModel,HomeTabStates>(
//           bloc: viewModel,
//           buildWhen: (previous, current) =>
//           current is BrandSuccessState || current is BrandLoadingState || current is BrandErrorState,
//           builder: ( context,  state) {
//             if(state is BrandLoadingState){
//               return Center(child: CircularProgressIndicator(color: AppColors.primaryColor,));
//             }
//             else if(state is BrandErrorState){
//               return Center(child: Text(state.errors.errorMessage));
//             }
//             else if(state is BrandSuccessState){
//               return _buildBrandSec(state.responseEntity.data!);
//
//             }
//             return Container();
//           },),
//         _buildNameCategory(name:' Important Products '),
//
//
//
//
//
//
//
//
//
//       ],));
//   }
//
//
//   ImageSlideshow _buildSlideShow({required List<String> images,}) {
//     return ImageSlideshow(
//       indicatorColor: AppColors.primaryColor,
//       initialPage: 0,
//       indicatorBottomPadding: 15.h,
//       indicatorPadding: 8.w,
//       indicatorRadius: 5,
//       indicatorBackgroundColor: AppColors.whiteColor,
//       isLoop: true,
//       autoPlayInterval: 3000,
//       height: 190.h,
//       children: images.map((url) {
//         return Image.asset(
//           // هنا يتم تكملة الكود بناءً على ملفاتك
//           url,
//           fit: BoxFit.cover,
//         );
//       }).toList(),
//     );}
//   Widget _buildNameCategory({required String name}) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           name,
//           style: AppStyles.medium14Header,
//         ),
//       ],
//     );
//   }
//   SizedBox _buildCategorySec(List<CategoryOrBrandEntity> categories) {
//     return SizedBox(
//       height: 250.h,
//       width: double.infinity,
//       child: GridView.builder(
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           mainAxisSpacing: 16.h,
//           crossAxisSpacing: 16.w,
//         ),
//         itemCount: categories.length,
//         scrollDirection: Axis.horizontal,
//         physics: const ScrollPhysics(),
//         itemBuilder: (context, index) {
//           return CategoryItem(item:categories[index] ,);
//         },
//       ), // GridView.builder
//     ); // SizedBox
//   }
//
//   SizedBox _buildBrandSec(List<CategoryOrBrandEntity> categories) {
//     return SizedBox(
//       height: 250.h,
//       width: double.infinity,
//       child: GridView.builder(
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           mainAxisSpacing: 16.h,
//           crossAxisSpacing: 16.w,
//         ),
//         itemCount: categories.length,
//         scrollDirection: Axis.horizontal,
//         physics: const ScrollPhysics(),
//         itemBuilder: (context, index) {
//           return CategoryItem(item:categories[index] ,);
//         },
//       ), // GridView.builder
//     ); // SizedBox
//   }
//
// }
//
//
//
//
//
//
//
//
//
//
//
