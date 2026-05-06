import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_routes.dart';
import '../../../../../../core/utils/flutter_toast.dart';
import '../../../../widgets/product_tab_item.dart';
import '../products_tab/cubit/products_tab_states.dart';
import '../products_tab/cubit/products_tab_view_model.dart';

class FavoriteTab extends StatelessWidget {
  const FavoriteTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductsTabViewModel, ProductsTabStates>(
      listener: ( context,  state) {
        if(state is AddCartSuccessState){
          ToastMessage.toastMsg(msg: 'Product added successfully',backgroundColor: AppColors.greenColor,textColor: AppColors.whiteColor);
        }
        if(state is AddCartErrorState){
          ToastMessage.toastMsg(msg: state.errorMessage.errorMessage,backgroundColor: AppColors.redColor,textColor: AppColors.whiteColor);

        }
      },
      listenWhen: (previous,current)=>
      current is AddCartSuccessState ||
          current is AddCartErrorState ,
      child: BlocBuilder<ProductsTabViewModel, ProductsTabStates>(
        builder: (context, state) {
          final viewModel = context.watch<ProductsTabViewModel>();

          // 🔥 Debug
          print("PRODUCTS: ${viewModel.productsList.length}");
          print("FAV IDS: ${viewModel.favoriteIds}");

          // ⚠️ لو المنتجات لسه بتتحمل
          if (viewModel.productsList.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final favProducts = viewModel.productsList
              .where((product) =>
              viewModel.favoriteIds.contains(product.id))
              .toList();

          if (favProducts.isEmpty) {
            return const Center(
              child: Text(
                "No Favorites Yet ❤️",
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          return Padding(
            padding: EdgeInsets.all(12.w),
            child: GridView.builder(
              itemCount: favProducts.length,
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.70,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemBuilder: (context, index) {
                return TweenAnimationBuilder(
                  duration: Duration(milliseconds: 400 + (index * 50)),
                  tween: Tween<double>(begin: 0, end: 1),
                  builder: (context, double value, child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.translate(
                        offset: Offset(0, (1 - value) * 20),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18.r),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.06),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(18.r),
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  AppRoutes.productDetailsRoute,
                                  arguments: favProducts[index],
                                );
                              },
                              child: ProductTabItem(
                                product: favProducts[index],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          );          },
      ),
    );
  }
}