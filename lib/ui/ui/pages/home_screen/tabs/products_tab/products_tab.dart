import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahl_shop/core/di/di.dart';
import 'package:sahl_shop/core/utils/app_assets.dart';
import 'package:sahl_shop/ui/ui/pages/home_screen/tabs/products_tab/cubit/products_tab_view_model.dart';
import 'package:sahl_shop/ui/ui/widgets/product_tab_item.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_routes.dart';
import 'cubit/products_tab_states.dart';

class ProductsTab extends StatelessWidget {
  ProductsTabViewModel viewModel=getIt<ProductsTabViewModel>();


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsTabViewModel,ProductsTabStates>(
      bloc: viewModel..getAllProducts(),
      builder: ( context,  state) {
        if(state is ProductTabLoadingState){
          return Center(child: CircularProgressIndicator(color:AppColors.primaryColor,));
        }else if(state is ProductTabSuccessState){
          return
          SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2 / 3.2.h,
                      crossAxisSpacing: 16.w,
                      mainAxisSpacing: 13.h,
                    ),
                    itemCount: state.responseEntity.products!.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          // todo: navigate to product details screen
                          Navigator.pushNamed(context,
                              AppRoutes.productDetailsRoute,
                              arguments: state.responseEntity.products![index]);
                        },
                        child:
                        ProductTabItem(product: state.responseEntity.products![index],),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }else if(state is ProductTabErrorState){
          return Center(child: Text(state.errorMessage!));
        }
        return Container();


      }
    );
  }
}