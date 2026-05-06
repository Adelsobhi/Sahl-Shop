import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sahl_shop/ui/ui/pages/home_screen/cubit/home_screen_states.dart';
import 'package:sahl_shop/ui/ui/pages/home_screen/tabs/products_tab/products_tab.dart';

import '../tabs/favorite_tab/favorite_tab.dart';
import '../tabs/home_tab/home_tab.dart';
import '../tabs/user_tab/user_tab.dart';

class HomeScreenViewModel  extends Cubit<HomeScreenStates>{
  HomeScreenViewModel():super(HomeInitialState());
  int selectedIndex=0;
  List<Widget>bodyList=[
    HomeTab(),
    ProductsTab(),
    FavoriteTab(),
    UserTab(),
    // HomeTap(),
    // ProductTap(),
    // FavoriteTap(),
    // UserTap(),
  ];

  void changeIndex(int index){
    selectedIndex=index;
    emit(HomeChangeSelectedIndexState());
  }
}