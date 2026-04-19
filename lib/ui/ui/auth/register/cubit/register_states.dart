import 'package:sahl_shop/core/errors/errors.dart';

import '../../../../../domain/entities/RegisterResponseEntity.dart';

abstract class RegisterStates {}
class RegisterInitialState extends RegisterStates  {}
class RegisterLoadingState extends RegisterStates  {}
class RegisterErrorState extends RegisterStates  {
  Errors errorMessage;
  RegisterErrorState({required this.errorMessage});
}
class RegisterSuccessState extends RegisterStates  {
  RegisterResponseEntity registerResponseEntity;
  RegisterSuccessState({required this.registerResponseEntity});

}


