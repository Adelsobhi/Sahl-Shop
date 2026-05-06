import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sahl_shop/core/utils/app_styles.dart';
import 'package:sahl_shop/core/utils/app_colors.dart';
import '../../../../core/utils/app_routes.dart';
import '../../../../core/utils/dialog_utils.dart';
import '../cart_screen/cubit/cart_view_model.dart';
import 'cubit/checkout_screen_view_model.dart';
import 'cubit/checkout_screen_states.dart';

class CheckoutScreen extends StatefulWidget {
  static String routeName = AppRoutes.checkoutRoute;

  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    final cartViewModel = CartViewModel.get(context);
    final checkoutVM = CheckoutScreenViewModel.get(context);
    final cartId = cartViewModel.cartId;

    return BlocConsumer<CheckoutScreenViewModel, CheckoutScreenStates>(
      listener: (context, state) {
        if (state is CheckoutSuccessState) {
          checkoutVM.detailsController.clear();
          checkoutVM.phoneController.clear();
          checkoutVM.cityController.clear();
          cartViewModel.cartList = [];

          showDialog(
            context: context,
            builder: (_) => Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22.r),
              ),
              child: Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check_circle, color: Colors.green, size: 60.sp),
                    SizedBox(height: 10.h),
                    Text(
                      "Order Placed Successfully",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      "We will contact you within a few hours.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 13.sp),
                    ),
                    SizedBox(height: 15.h),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          AppRoutes.homeRoute,
                              (route) => false,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: const Text("OK"),
                    )
                  ],
                ),
              ),
            ),
          );
        }

        if (state is CheckoutErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage.errorMessage)),
          );
        }
      },

      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xffF5F6FA),

          appBar: AppBar(
            title: const Text("Checkout"),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.white,
            foregroundColor: AppColors.primaryColor,
          ),

          body: Form(
            key: checkoutVM.formKey,
            child: Column(
              children: [

                /// ================= HEADER =================
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.all(12.w),
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    "Cash on Delivery - Delivery fees included",
                    style: TextStyle(fontSize: 13.sp),
                  ),
                ),

                /// ================= CART =================
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    itemCount: cartViewModel.cartList.length,
                    itemBuilder: (context, index) {
                      final item = cartViewModel.cartList[index];

                      return Container(
                        margin: EdgeInsets.only(bottom: 10.h),
                        padding: EdgeInsets.all(10.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            )
                          ],
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.r),
                              child: Image.network(
                                item.product!.imageCover!,
                                width: 70.w,
                                height: 70.h,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.product!.title!,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13.sp,
                                    ),
                                  ),
                                  SizedBox(height: 5.h),
                                  Text(
                                    "${item.price} EGP",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                /// ================= FORM + TOTAL =================
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20.r),
                    ),
                  ),
                  child: Column(
                    children: [

                      _buildInput(
                        controller: checkoutVM.detailsController,
                        hint: "Address",
                        icon: Icons.location_on,
                        validator: (v) =>
                        v!.isEmpty ? "Required" : null,
                      ),

                      SizedBox(height: 10.h),

                      _buildInput(
                        controller: checkoutVM.phoneController,
                        hint: "Phone",
                        icon: Icons.phone,
                        keyboardType: TextInputType.phone,
                        validator: (v) =>
                        v!.isEmpty ? "Required" : null,
                      ),

                      SizedBox(height: 10.h),

                      _buildInput(
                        controller: checkoutVM.cityController,
                        hint: "City",
                        icon: Icons.location_city,
                        validator: (v) =>
                        v!.isEmpty ? "Required" : null,
                      ),

                      SizedBox(height: 15.h),

                      /// TOTAL CARD
                      Container(
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Total"),
                            Text(
                              "${cartViewModel.getCartResponseEntity.data?.totalCartPrice ?? 0} EGP",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                                fontSize: 16.sp,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 15.h),

                      /// BUTTON
                      SizedBox(
                        width: double.infinity,
                        height: 50.h,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14.r),
                            ),
                          ),
                          onPressed: () {
                            checkoutVM.createOrder(
                              cartId: cartId,
                              details: checkoutVM.detailsController.text,
                              phone: checkoutVM.phoneController.text,
                              city: checkoutVM.cityController.text,
                            );
                          },
                          child: const Text(
                            "Confirm Order",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInput({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, color: AppColors.primaryColor),
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}




