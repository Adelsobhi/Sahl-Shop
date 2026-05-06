
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sahl_shop/core/di/di.dart';
import 'package:sahl_shop/core/utils/app_styles.dart';
import 'package:sahl_shop/core/utils/dialog_utils.dart';
import 'package:sahl_shop/ui/ui/auth/register/cubit/register_states.dart';
import 'package:sahl_shop/ui/ui/auth/register/cubit/register_view_model.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_routes.dart';
import '../../../../core/utils/app_validators.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';

class RegisterScreen extends StatefulWidget {
  static  String routeName =AppRoutes.registerRoute ;

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
   RegisterViewModel viewModel= getIt<RegisterViewModel>();



  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterViewModel,RegisterStates>(
      bloc:   viewModel,
      listener: (context , state){
        if(state is RegisterLoadingState){
          DialogUtils.showLoading(context: context, message: 'Loading...');

        }
        else if(state is RegisterErrorState){
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(context: context, message:state.errorMessage.errorMessage,posActionName: 'ok',title: 'Error');
        }
        else if(state is RegisterSuccessState){
          DialogUtils.hideLoading(context);
          DialogUtils.showMessage(context: context, message:'Register successfully',posActionName: 'ok',title: 'Success',posAction: (){
            Navigator.of(context).pushReplacementNamed(AppRoutes.loginRoute);
          });

        }
      },
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
                    top: 50.h,
                    bottom: 10.h,
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
                               Text("Full Name" ,style: AppStyles.medium12White,),
                              CustomTextFormField(
                                isPassword: false,
                                keyboardType: TextInputType.name,
                                isObscureText: false,
                                hintText: "enter your full name",
                                hintStyle: AppStyles.light12HintText,
                                filledColor: AppColors.whiteColor,
                                controller: viewModel.fullNameController,
                                validator: AppValidators.validateFullName,
                              ),
                              Text("Phone Number" ,style: AppStyles.medium12White,),
                              CustomTextFormField(
                                isPassword: false,
                                keyboardType: TextInputType.phone,
                                isObscureText: false,
                                hintText: "enter your Phone Number",
                                hintStyle: AppStyles.light12HintText,
                                filledColor: AppColors.whiteColor,
                                controller: viewModel.phoneController,
                                validator: AppValidators.validatePhoneNumber,
                              ),
                              Text("E-mail address", style: AppStyles.medium12White,),
                              CustomTextFormField(
                                isPassword: false,
                                keyboardType: TextInputType.emailAddress,
                                isObscureText: false,
                                hintText: "enter your email address",
                                hintStyle: AppStyles.light12HintText,
                                filledColor: AppColors.whiteColor,
                                controller:  viewModel.emailController,
                                validator: AppValidators.validateEmail,
                              ), // CustomTextFormField
                              Text("Password", style: AppStyles.medium12White,),
                              CustomTextFormField(
                                isPassword: true,
                                keyboardType: TextInputType.visiblePassword,
                                isObscureText: true,
                                hintText: "enter your password",
                                hintStyle: AppStyles.light12HintText,
                                filledColor: AppColors.whiteColor,
                                controller:  viewModel.passwordController,
                                validator: AppValidators.validatePassword,
                                suffixIcon: IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.visibility_off),
                                ),
                              ),
                              Text("Re-Password", style: AppStyles.medium12White,),
                              CustomTextFormField(
                                isPassword: true,
                                keyboardType: TextInputType.visiblePassword,
                                isObscureText: true,
                                hintText: "enter your re-password",
                                hintStyle: AppStyles.light12HintText,
                                filledColor: AppColors.whiteColor,
                                controller:  viewModel.confirmPasswordController,
                                validator: AppValidators.validatePassword,
                                suffixIcon: IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.visibility_off),
                                ),
                              ),
      
                              Padding(
                                padding: EdgeInsets.only(top: 35.h),
                                child: CustomElevatedButton(
                                  backgroundColor: AppColors.whiteColor,
                                  textStyle: AppStyles.semi16Primary,
                                  text: "Sign up",
                                  onPressed: () {
                                    viewModel.register();
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 10.h, bottom: 30.h),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacementNamed(
                                      context,
                                      AppRoutes.loginRoute,
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Already have an account? login',
      
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

