import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahl_shop/core/utils/app_routes.dart';
import 'package:sahl_shop/ui/ui/auth/login/login_screen.dart';
import 'package:sahl_shop/ui/ui/auth/register/register_screen.dart';
import 'package:sahl_shop/ui/ui/pages/home_screen/home_screen.dart';
import 'package:sahl_shop/ui/ui/pages/product_details_screen/product_details_screen.dart';

import 'core/di/di.dart';
import 'core/utils/my_bloc_observer.dart';



void main() {
  configureDependencies();
  Bloc.observer = MyBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.homeRoute,
          routes: {
            AppRoutes.registerRoute: (context) => RegisterScreen(),
            AppRoutes.loginRoute: (context) => LoginScreen(),
            AppRoutes.homeRoute: (context) =>  HomeScreen(),
            AppRoutes.productDetailsRoute: (context) => ProductDetailsScreen(),
          },
        );
      },
    );
  }
}