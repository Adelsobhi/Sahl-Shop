import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahl_shop/core/di/di.dart';
import 'package:sahl_shop/ui/ui/pages/home_screen/tabs/home_tab/cubit/home_tab_states.dart';
import 'package:sahl_shop/ui/ui/pages/home_screen/tabs/home_tab/cubit/home_tab_view_model.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_routes.dart';
import '../../../../../../core/utils/flutter_toast.dart';
import '../../../../../../domain/entities/CategoryOrBrandResponseEntity.dart';
import '../../../../widgets/product_tab_item.dart';
import 'cubit/products_tab_states.dart';
import 'cubit/products_tab_view_model.dart';
import 'cubit_sub_category/sub_category_states.dart';
import 'cubit_sub_category/sub_category_view_model.dart';

class ProductsTab extends StatefulWidget {
  @override
  State<ProductsTab> createState() => _ProductsTabState();
}

class _ProductsTabState extends State<ProductsTab> {
  final HomeTabViewModel viewModel = getIt<HomeTabViewModel>();
  final SubCategoryViewModel subCategoryViewModel = getIt<SubCategoryViewModel>();
  // جعل الـ ViewModel متاحاً لضمان استخدام نفس النسخة
  late ProductsTabViewModel productsViewModel;

  int selectedIndex = -1;
  String? selectedCategoryId;

  @override
  void initState() {
    super.initState();
    // نستخدم الـ context للحصول على الـ ViewModel لضمان أن البحث من الـ AppBar يسمع هنا
    productsViewModel = ProductsTabViewModel.get(context);
    viewModel.getAllCategories();
    productsViewModel.getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ================= CATEGORIES =================
          BlocBuilder<HomeTabViewModel, HomeTabStates>(
            bloc: viewModel,
            builder: (context, state) {
              if (state is CategoryLoadingState) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is CategoryErrorState) {
                return Center(child: Text(state.errors.errorMessage));
              }

              if (state is CategorySuccessState) {
                final categories = state.responseEntity.data!;

                return SizedBox(
                  height: 160.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final isSelected = selectedIndex == index;
                      final category = categories[index];

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                            selectedCategoryId = category.id;
                          });
                          subCategoryViewModel.getSubCategories(category.id!);
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 8.w),
                          child: Column(
                            children: [
                              Container(
                                width: 90.w,
                                height: 90.w,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isSelected ? AppColors.primaryColor : Colors.grey,
                                    width: 2,
                                  ),
                                ),
                                child: ClipOval(
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl: category.image ?? "",
                                    placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) => const Icon(Icons.image),
                                  ),
                                ),
                              ),
                              SizedBox(height: 6.h),
                              SizedBox(
                                width: 70.w,
                                child: Text(
                                  category.name ?? "",
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: isSelected ? AppColors.primaryColor : Colors.black,
                                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
              return const SizedBox();
            },
          ),
          SizedBox(height: 10.h),

          // دالة عرض المنتجات المفلترة
          _buildProductsSection(),
        ],
      ),
    );
  }

  // ================= PRODUCTS SECTION =================
  Widget _buildProductsSection() {
    return BlocListener<ProductsTabViewModel, ProductsTabStates>(
      listener: (context, state) {
        if (state is AddCartSuccessState) {
          ToastMessage.toastMsg(
              msg: 'Product added successfully',
              backgroundColor: AppColors.greenColor,
              textColor: AppColors.whiteColor);
        }
        if (state is AddCartErrorState) {
          ToastMessage.toastMsg(
              msg: state.errorMessage.errorMessage,
              backgroundColor: AppColors.redColor,
              textColor: AppColors.whiteColor);
        }
      },
      listenWhen: (previous, current) =>
      current is AddCartSuccessState || current is AddCartErrorState,
      child: BlocBuilder<ProductsTabViewModel, ProductsTabStates>(
        // نستخدم الـ ViewModel لضمان سماع التغييرات
        bloc: productsViewModel,
        builder: (context, state) {
          // 1. حالة التحميل فقط إذا كانت القائمة الأصلية فارغة
          if (state is ProductTabLoadingState && productsViewModel.productsList.isEmpty) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            );
          }

          if (state is ProductTabErrorState) {
            return Center(child: Text(state.errorMessage.errorMessage));
          }

          // 2. استخدام القائمة المفلترة المخصصة للبحث
          final products = productsViewModel.SearchProductsList;

          // 3. عرض رسالة عند عدم وجود نتائج بحث
          if (products.isEmpty && state is! ProductTabLoadingState) {
            return Center(
              child: Padding(
                padding: EdgeInsets.only(top: 50.h),
                child: Text("No products found", style: TextStyle(fontSize: 14.sp, color: Colors.grey)),
              ),
            );
          }

          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: products.length, // يعتمد على عدد العناصر المفلترة
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2 / 3.1,
              crossAxisSpacing: 16.w,
              mainAxisSpacing: 16.h,
            ),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.productDetailsRoute,
                    arguments: products[index],
                  );
                },
                child: ProductTabItem(product: products[index]),
              );
            },
          );
        },
      ),
    );
  }
}