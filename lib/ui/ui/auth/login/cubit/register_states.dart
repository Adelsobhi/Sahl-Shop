import 'package:sahl_shop/core/errors/errors.dart';

import '../../../../../domain/entities/LoginResponseEntity.dart';
import '../../../../../domain/entities/RegisterResponseEntity.dart';

abstract class LoginStates {}
class LoginInitialState extends LoginStates  {}
class LoginLoadingState extends LoginStates  {}
class LoginErrorState extends LoginStates  {
  Errors errorMessage;
  LoginErrorState({required this.errorMessage});
}
class LoginSuccessState extends LoginStates  {
  LoginResponseEntity loginResponseEntity;
  LoginSuccessState({required this.loginResponseEntity});

}


