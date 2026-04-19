import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sahl_shop/ui/ui/pages/home_screen/cubit/home_screen_states.dart';

import '../tabs/home_tab/home_tab.dart';

class HomeScreenViewModel  extends Cubit<HomeScreenStates>{
  HomeScreenViewModel():super(HomeInitialState());
  int selectedIndex=0;
  List<Widget>bodyList=[
    HomeTab(),
    Container(color: Colors.yellow,height: 400,),
    Container(color: Colors.teal,height: 400,),
    Container(color: Colors.orangeAccent,height: 400,),
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