import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sahl_shop/core/cache/shared_preference.dart'; // تأكد من استيراد الكاش
import 'package:sahl_shop/ui/ui/auth/register/cubit/register_states.dart';
import '../../../../../domain/use_cases/register_use_case.dart';

@injectable
class RegisterViewModel extends Cubit<RegisterStates> {
  var formKey = GlobalKey<FormState>();
  TextEditingController fullNameController = TextEditingController(text: 'adel1111');
  TextEditingController phoneController = TextEditingController(text: '01010700701');
  TextEditingController emailController = TextEditingController(text: 'adel1111@gmail.com');
  TextEditingController passwordController = TextEditingController(text: 'adel@123');
  TextEditingController confirmPasswordController = TextEditingController(text: 'adel@123');

  RegisterUseCase registerUseCase;
  RegisterViewModel({required this.registerUseCase}) : super(RegisterInitialState());

  void register() async {
    if (formKey.currentState!.validate()) {
      emit(RegisterLoadingState());

      var either = await registerUseCase.invoke(
          fullNameController.text,
          emailController.text,
          passwordController.text,
          confirmPasswordController.text,
          phoneController.text);

      either.fold(
            (error) => emit(RegisterErrorState(errorMessage: error)),
            (response) async {
          // --- التعديل هنا: حفظ البيانات قبل إرسال حالة النجاح ---
          if (response.token != null) {
            await SharedPreference.saveData(key: 'token', value: response.token);
            await SharedPreference.saveData(key: 'userName', value: response.user?.name);
            await SharedPreference.saveData(key: 'userEmail', value: response.user?.email);
            await SharedPreference.saveData(key: 'userPhone', value: phoneController.text);
          }

          emit(RegisterSuccessState(registerResponseEntity: response));
        },
      );
    }
  }
}