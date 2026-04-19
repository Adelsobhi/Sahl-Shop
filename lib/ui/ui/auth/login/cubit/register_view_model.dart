import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sahl_shop/ui/ui/auth/login/cubit/register_states.dart';
import 'package:sahl_shop/ui/ui/auth/register/cubit/register_states.dart';

import '../../../../../domain/use_cases/login_use_case.dart';
import '../../../../../domain/use_cases/register_use_case.dart';
@injectable
class LoginViewModel extends Cubit<LoginStates> {
  var formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController(text: 'adel1111@gmail.com');
  TextEditingController passwordController = TextEditingController(text: 'adel@123');

   LoginUseCase loginUseCase;
  LoginViewModel({required this.loginUseCase}):super(LoginInitialState());
  void login() async {
    if (formKey.currentState!.validate()) {
      emit(LoginLoadingState());
      var either = await loginUseCase.invoke(
          emailController.text,
          passwordController.text,);
      either.fold((error) => emit(LoginErrorState(errorMessage: error)),
              (response) =>
              emit(LoginSuccessState( loginResponseEntity: response)));
    }
  }
}