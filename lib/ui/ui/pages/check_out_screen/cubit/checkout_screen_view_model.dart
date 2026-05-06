import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../../domain/entities/OrderResponseEntity.dart';
import '../../../../../domain/use_cases/order_use_case.dart';
import 'checkout_screen_states.dart';
@injectable
class CheckoutScreenViewModel extends Cubit<CheckoutScreenStates> {
   OrderUseCase orderUseCase;
   OrderResponseEntity orderResponseEntity=OrderResponseEntity();
   var formKey = GlobalKey<FormState>();

    TextEditingController detailsController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController cityController = TextEditingController();
  CheckoutScreenViewModel(this.orderUseCase)
      : super(CheckoutInitialState());

  static CheckoutScreenViewModel get(context) =>
      BlocProvider.of(context);

  void createOrder({
    required String cartId,
    required String details,
    required String phone,
    required String city,
  }) async {

    if (formKey.currentState!.validate()) {
      emit(CheckoutLoadingState());
      var either = await orderUseCase.invoke(cartId: cartId, details: details, phone: phone, city: city);
      either.fold((error) =>
          emit(CheckoutErrorState(errorMessage: error)),
              (response) =>
              emit(CheckoutSuccessState(orderResponseEntity: response)));
    }
  }
}