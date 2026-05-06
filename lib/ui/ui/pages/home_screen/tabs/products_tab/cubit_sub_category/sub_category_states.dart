import 'package:sahl_shop/domain/entities/SubCategoryResponseEntity.dart';

import '../../../../../../../core/errors/errors.dart';

class SubCategoryStates {

}
class SubCategoryInitialState extends SubCategoryStates{}
class SubCategoryLoadingState extends SubCategoryStates{}
class SubCategorySuccessState extends SubCategoryStates{
  SubCategoryResponseEntity responseEntity;
  SubCategorySuccessState({required this.responseEntity});
}
class SubCategoryErrorState extends SubCategoryStates{
  Errors errorMessage;
  SubCategoryErrorState({required this.errorMessage});
}