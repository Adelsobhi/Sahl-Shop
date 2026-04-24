 import 'package:sahl_shop/core/errors/errors.dart';
import 'package:sahl_shop/domain/entities/ProductResponseEntity.dart';

class ProductsTabStates{}
class ProductTabInitialState extends ProductsTabStates{}
 class ProductTabLoadingState extends ProductsTabStates{}
 class ProductTabSuccessState extends ProductsTabStates{
  ProductResponseEntity responseEntity;
  ProductTabSuccessState({required this.responseEntity});
 }
 class ProductTabErrorState extends ProductsTabStates{
   String? errorMessage;
   ProductTabErrorState({required this.errorMessage});
 }

