 import 'package:sahl_shop/core/errors/errors.dart';
import 'package:sahl_shop/domain/entities/AddCartResponseEntity.dart';
import 'package:sahl_shop/domain/entities/ProductResponseEntity.dart';

class ProductsTabStates{}
class ProductTabInitialState extends ProductsTabStates{}
 class ProductTabLoadingState extends ProductsTabStates{}
 class ProductTabSuccessState extends ProductsTabStates{
   ProductResponseEntity responseEntity;
   ProductTabSuccessState({required this.responseEntity});
 }
 class ProductTabErrorState extends ProductsTabStates{
   Errors errorMessage;
   ProductTabErrorState({required this.errorMessage});
 }

 class AddCartLoadingState extends ProductsTabStates{}
 class AddCartSuccessState extends ProductsTabStates{
   AddCartResponseEntity responseEntity;
   AddCartSuccessState({required this.responseEntity});
 }
 class AddCartErrorState extends ProductsTabStates{
   Errors errorMessage;
   AddCartErrorState({required this.errorMessage});
 }
 class FavoriteUpdatedState extends ProductsTabStates {}
 class ProductSearchState extends ProductsTabStates {}
