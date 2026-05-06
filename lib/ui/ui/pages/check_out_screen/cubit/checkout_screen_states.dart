import 'package:sahl_shop/core/errors/errors.dart';

import '../../../../../domain/entities/OrderResponseEntity.dart';

abstract class CheckoutScreenStates {}

class CheckoutInitialState extends CheckoutScreenStates {}
class CheckoutLoadingState extends CheckoutScreenStates {}
class CheckoutSuccessState extends CheckoutScreenStates {
  final OrderResponseEntity orderResponseEntity;

  CheckoutSuccessState( {required this.orderResponseEntity});
}

class CheckoutErrorState extends CheckoutScreenStates {

   Errors errorMessage;

  CheckoutErrorState( {required this.errorMessage});
}

