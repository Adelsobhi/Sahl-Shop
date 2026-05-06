import 'package:sahl_shop/core/errors/errors.dart';

import '../../../../../domain/entities/GetCartResponseEntity.dart';

abstract class CartStates {}
class GetCartLoadingState extends CartStates{}
class GetCartErrorState extends CartStates{
  Errors error;
  GetCartErrorState({ required this.error});
}
class GetCartSuccessState extends CartStates{
  GetCartResponseEntity getCartResponseEntity;
  GetCartSuccessState({required this.getCartResponseEntity});
}



class DeleteItemInCartLoadingState extends CartStates{}
class DeleteItemInCartErrorState extends CartStates{
  Errors error;
  DeleteItemInCartErrorState({ required this.error});
}
class DeleteItemInCartSuccessState extends CartStates{
  GetCartResponseEntity getCartResponseEntity;
  DeleteItemInCartSuccessState({required this.getCartResponseEntity});
}




class UpdateItemInCartLoadingState extends CartStates{}
class UpdateItemInCartErrorState extends CartStates{
  Errors error;
  UpdateItemInCartErrorState({ required this.error});
}
class UpdateItemInCartSuccessState extends CartStates{
  GetCartResponseEntity getCartResponseEntity;
  UpdateItemInCartSuccessState({required this.getCartResponseEntity});
}