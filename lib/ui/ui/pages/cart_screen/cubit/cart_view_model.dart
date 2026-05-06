import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sahl_shop/domain/entities/GetCartResponseEntity.dart';
import 'package:sahl_shop/domain/use_cases/delete_items_in_cart_use_case.dart';
import 'package:sahl_shop/domain/use_cases/update_count_in_cart_use_case.dart';
import 'package:sahl_shop/ui/ui/pages/cart_screen/cubit/cart_states.dart';

import '../../../../../domain/use_cases/get_items_in_cart_use_case.dart';
@injectable
class CartViewModel extends Cubit<CartStates>{
  CartViewModel({required this.getItemsInCartUseCase,required this.deleteItemsInCartUseCase,required this.updateCountInCartUseCase}) : super(GetCartLoadingState());
  GetItemsInCartUseCase getItemsInCartUseCase;
  DeleteItemsInCartUseCase deleteItemsInCartUseCase;
  UpdateCountInCartUseCase updateCountInCartUseCase;
  List<GetProductsEntity> cartList=[];
  GetCartResponseEntity getCartResponseEntity=GetCartResponseEntity();
  var cartId;



  static CartViewModel get(context)=>BlocProvider.of<CartViewModel>(context);
  getItemsInCart()async {
    emit(GetCartLoadingState());
    var either= await getItemsInCartUseCase.invoke();
    either.fold((error)=>emit(GetCartErrorState(error: error)), (response){
      cartList= response.data!.products!;
      getCartResponseEntity=response;
       cartId = response.cartId?? response.data?.id;

      emit(GetCartSuccessState(getCartResponseEntity: response));
    });




  }
  deleteItemsInCart(String productId)async {
    var either= await deleteItemsInCartUseCase.invoke(productId);
    either.fold((error)=>emit(DeleteItemInCartErrorState(error: error)), (response){
      // cartList= response.data!.products!;
      print('deleted item in cart ');
      emit(GetCartSuccessState(getCartResponseEntity: response));
    });

  }


  updateItemsInCart(String productId,int count)async {
    var either= await updateCountInCartUseCase.invoke(productId,count);
    either.fold((error)=>emit(UpdateItemInCartErrorState(error: error)), (response){
      // cartList= response.data!.products!;
      print('deleted item in cart ');
      emit(GetCartSuccessState(getCartResponseEntity: response));
    });

  }

}