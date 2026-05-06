import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_routes.dart';
import '../../../../core/utils/app_styles.dart';
import 'cubit/cart_states.dart';
import 'cubit/cart_view_model.dart';

class CartScreen extends StatelessWidget {
  static final String routeName = AppRoutes.cartRoute;

  @override
  Widget build(BuildContext context) {
    CartViewModel viewModel = CartViewModel.get(context);

    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),

      appBar: AppBar(
        title: const Text("My Cart"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: AppColors.primaryColor,
      ),

      body: BlocBuilder<CartViewModel, CartStates>(
        bloc: viewModel..getItemsInCart(),
        builder: (context, state) {

          if (state is GetCartLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is GetCartSuccessState) {
            var products = state.getCartResponseEntity.data!.products!;
            viewModel.cartList = products;

            if (products.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.shopping_cart_outlined,
                        size: 80, color: Colors.grey),
                    SizedBox(height: 10),
                    Text("Your cart is empty"),
                  ],
                ),
              );
            }

            return Column(
              children: [

                /// ================= PRODUCTS =================
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(12.w),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      var item = products[index];

                      return Container(
                        margin: EdgeInsets.only(bottom: 12.h),
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            )
                          ],
                        ),
                        child: Row(
                          children: [

                            /// IMAGE
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12.r),
                              child: Image.network(
                                item.product!.imageCover!,
                                width: 75.w,
                                height: 75.h,
                                fit: BoxFit.cover,
                              ),
                            ),

                            SizedBox(width: 12.w),

                            /// INFO
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Text(
                                    item.product!.title!,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  SizedBox(height: 5.h),

                                  Text(
                                    item.product!.brand?.name ?? "",
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.grey,
                                    ),
                                  ),

                                  SizedBox(height: 6.h),

                                  Text(
                                    "${item.price} EGP",
                                    style: TextStyle(
                                      color: AppColors.primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  SizedBox(height: 10.h),

                                  /// QUANTITY CONTROL (modern pill)
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.w, vertical: 4.h),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      borderRadius: BorderRadius.circular(20.r),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [

                                        GestureDetector(
                                          onTap: () {
                                            int count = item.count!.toInt();
                                            if (count > 1) {
                                              viewModel.updateItemsInCart(
                                                item.product!.id!,
                                                count - 1,
                                              );
                                            }
                                          },
                                          child: Icon(Icons.remove,
                                              size: 18.sp),
                                        ),

                                        SizedBox(width: 10.w),

                                        Text(
                                          item.count.toString(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),

                                        SizedBox(width: 10.w),

                                        GestureDetector(
                                          onTap: () {
                                            int count = item.count!.toInt();
                                            viewModel.updateItemsInCart(
                                              item.product!.id!,
                                              count + 1,
                                            );
                                          },
                                          child: Icon(Icons.add,
                                              size: 18.sp),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            /// DELETE
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.red.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: Icon(Icons.delete,
                                    color: Colors.red, size: 20.sp),
                                onPressed: () {
                                  viewModel.deleteItemsInCart(
                                      item.product!.id!);
                                },
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),

                /// ================= BOTTOM BAR =================
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                    BorderRadius.vertical(top: Radius.circular(25.r)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 15,
                      )
                    ],
                  ),
                  child: Row(
                    children: [

                      /// TOTAL
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Total",
                                style: TextStyle(color: Colors.grey)),
                            Text(
                              "${state.getCartResponseEntity.data?.totalCartPrice ?? 0} EGP",
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),

                      /// CHECKOUT BUTTON
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, AppRoutes.checkoutRoute);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          padding: EdgeInsets.symmetric(
                              horizontal: 25.w, vertical: 14.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.r),
                          ),
                        ),
                        child: Row(
                          children: [
                            Text("Checkout",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.sp)),
                            SizedBox(width: 5.w),
                            const Icon(Icons.arrow_forward,
                                color: Colors.white),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            );
          }

          if (state is GetCartErrorState) {
            return Center(child: Text(state.error.errorMessage));
          }

          return const SizedBox();
        },
      ),
    );
  }
}