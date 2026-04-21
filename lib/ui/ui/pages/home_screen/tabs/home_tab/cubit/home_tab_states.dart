
import 'package:sahl_shop/core/errors/errors.dart';

import '../../../../../../../domain/entities/CategoryOrBrandResponseEntity.dart';

abstract class HomeTabStates {}

class HomeTabInitialState extends HomeTabStates {}

class CategoryLoadingState extends HomeTabStates {}

class CategoryErrorState extends HomeTabStates {
  final Errors errors;
  CategoryErrorState({required this.errors});
}

class CategorySuccessState extends HomeTabStates {
  final CategoryOrBrandResponseEntity responseEntity;

  CategorySuccessState({required this.responseEntity});

}
class BrandLoadingState extends HomeTabStates {}

class BrandErrorState extends HomeTabStates {
  final Errors errors;
 BrandErrorState({required this.errors});
}

class BrandSuccessState extends HomeTabStates {
  final CategoryOrBrandResponseEntity responseEntity;

BrandSuccessState({required this.responseEntity});
}