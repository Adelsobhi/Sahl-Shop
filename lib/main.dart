import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahl_shop/core/utils/app_routes.dart';
import 'package:sahl_shop/ui/ui/auth/login/login_screen.dart';
import 'package:sahl_shop/ui/ui/auth/register/register_screen.dart';
import 'package:sahl_shop/ui/ui/pages/cart_screen/cart_screen.dart';
import 'package:sahl_shop/ui/ui/pages/cart_screen/cubit/cart_view_model.dart';
import 'package:sahl_shop/ui/ui/pages/check_out_screen/checkout_screen.dart';
import 'package:sahl_shop/ui/ui/pages/check_out_screen/cubit/checkout_screen_view_model.dart';
import 'package:sahl_shop/ui/ui/pages/home_screen/home_screen.dart';
import 'package:sahl_shop/ui/ui/pages/home_screen/tabs/products_tab/cubit/products_tab_view_model.dart';
import 'package:sahl_shop/ui/ui/pages/home_screen/tabs/products_tab/products_tab.dart';
import 'package:sahl_shop/ui/ui/pages/product_details_screen/product_details_screen.dart';

import 'core/cache/shared_preference.dart';
import 'core/di/di.dart';
import 'core/utils/my_bloc_observer.dart';



void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  Bloc.observer = MyBlocObserver();
  await SharedPreference.init();
  runApp( MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<ProductsTabViewModel>()..getAllProducts()..loadFavorites()),
        BlocProvider(create: (context) => getIt<CartViewModel>()..getItemsInCart()),
        BlocProvider(
          create: (context) => getIt<CheckoutScreenViewModel>(),
        ),
  ],
  child: MyApp(initialRoute: SharedPreference.getData(key: 'token')==null?AppRoutes.loginRoute:AppRoutes.homeRoute,)));
}

class MyApp extends StatelessWidget {

  String initialRoute;
  MyApp({required this.initialRoute});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: initialRoute,

          routes: {
            AppRoutes.registerRoute: (context) => RegisterScreen(),
            AppRoutes.loginRoute: (context) => LoginScreen(),
            AppRoutes.homeRoute: (context) =>  HomeScreen(),
            AppRoutes.productDetailsRoute: (context) => ProductDetailsScreen(),
            AppRoutes.cartRoute: (context) => CartScreen(),
            AppRoutes.productsRoute: (context) => ProductsTab(),
            AppRoutes.checkoutRoute: (context) => CheckoutScreen(),
          },
        );
      },
    );
  }
}