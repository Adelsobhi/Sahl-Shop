
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahl_shop/core/di/di.dart';
import 'package:sahl_shop/core/utils/app_styles.dart';
import 'package:sahl_shop/core/utils/dialog_utils.dart';
import 'package:sahl_shop/ui/ui/auth/login/cubit/register_view_model.dart';
import '../../../../core/cache/shared_preference.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_routes.dart';
import '../../../../core/utils/app_validators.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'cubit/register_states.dart';
class LoginScreen extends StatefulWidget {
  static  String routeName =AppRoutes.loginRoute ;

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
 LoginViewModel viewModel = getIt<LoginViewModel>();
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginViewModel,LoginStates>(
      bloc: viewModel,
      listener: (context, state){
        if(state is LoginSuccessState) {
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(context: context, message: "Login Success",title: 'Success',posActionName: 'ok',posAction: (){
              SharedPreference.saveData(key: 'token', value: state.loginResponseEntity.token);
            Navigator.of(context).pushReplacementNamed(AppRoutes.homeRoute);
          });

        }else if(state is LoginErrorState){
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(context: context, message: state.errorMessage.errorMessage,title: 'Error',posActionName: 'ok');

        }else if(state is LoginLoadingState){
          DialogUtils.showLoading(context: context,
              message: 'Waiting..');
        }

      } ,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppAssets.backGroundAuth),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
      
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 140.h,
                    bottom: 30.h,
                    left: 97.w,
                    right: 97.w,
                  ),
                  child: Image.asset(
                    AppAssets.logoApp,
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
      
                    children: [
                      Padding(
                        padding:  EdgeInsets.only(top: 20.h),
                        child: Form(
                          key: viewModel.formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text('Welcome Back To Sahl Shop',style: AppStyles.semi16White,),
                              Text('Please sign in with email',style: AppStyles.light12White,),
                              SizedBox(
                                height:50.h  ,
                              ),
                              Text("E-mail address" ,style: AppStyles.medium12White,),
                              CustomTextFormField(
                                isPassword: false,
                                keyboardType: TextInputType.name,
                                isObscureText: false,
                                hintText: "enter your E-mail address",
                                hintStyle: AppStyles.light12HintText,
                                filledColor: AppColors.whiteColor,
                                controller: viewModel.emailController,
                                validator: AppValidators.validateFullName,
                              ),
      
                              Text("Password", style: AppStyles.medium12White,),
                              CustomTextFormField(
                                isPassword: true,
                                keyboardType: TextInputType.visiblePassword,
                                isObscureText: true,
                                hintText: "enter your password",
                                hintStyle: AppStyles.light12HintText,
                                filledColor: AppColors.whiteColor,
                                controller: viewModel.passwordController,
                                validator: AppValidators.validatePassword,
                                suffixIcon: IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.visibility_off),
                                ),
                              ),
                              SizedBox(
                                height:30.h  ,
                              ),
      
      
                              Padding(
                                padding: EdgeInsets.only(top: 35.h),
                                child: CustomElevatedButton(
                                  backgroundColor: AppColors.whiteColor,
                                  textStyle: AppStyles.semi16Primary,
                                  text: "Login",
                                  onPressed: () {
                                    viewModel.login();
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 10.h, bottom: 30.h),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacementNamed(
                                      context,
                                      AppRoutes.registerRoute,
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Don’t have an account? Create Account',
                                          style: AppStyles.medium12White.copyWith(
                                            fontSize: 10
                                          ),
                                          maxLines: 1,
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
      
      
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
}
