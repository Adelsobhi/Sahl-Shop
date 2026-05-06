import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:sahl_shop/core/cache/shared_preference.dart';
import 'package:sahl_shop/core/utils/app_routes.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_styles.dart';
import 'cubit/user_tab_states.dart';
import 'cubit/user_tab_view_model.dart';

class UserTab extends StatelessWidget {
  const UserTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance<UserTabViewModel>()
        ..getUserData()
        ..loadImage(),
      child: Scaffold(
        body: BlocConsumer<UserTabViewModel, UserTabStates>(
          listener: (context, state) {
            if (state is UserTabErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage)),
              );
            }
          },
          builder: (context, state) {
            var viewModel = context.read<UserTabViewModel>();

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- Header ---
                  SizedBox(height: 40.h),
                  Row(
                    children: [
                      Text("My Profile", style: AppStyles.medium14Primary),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          SharedPreference.removeData(key: 'token');
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            AppRoutes.loginRoute,
                                (route) => false,
                          );
                        },
                        icon: Icon(Icons.logout_outlined,
                            color: AppColors.primaryColor, size: 30.sp),
                      ),
                    ],
                  ),

                  SizedBox(height: 20.h),

                  // --- Profile Image Section ---
                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 60.r,
                          backgroundColor: Colors.grey.shade200,
                          child: ClipOval(
                            child: viewModel.profileImage != null
                                ? Image.file(
                              viewModel.profileImage!,
                              width: 120.r,
                              height: 120.r,
                              fit: BoxFit.cover,
                            )
                                : Icon(Icons.person,
                                size: 60.sp, color: Colors.grey),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () => viewModel.pickImage(),
                            child: Container(
                              padding: EdgeInsets.all(8.w),
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 2),
                              ),
                              child: state is UserTabLoadingState
                                  ? SizedBox(
                                width: 20.sp,
                                height: 20.sp,
                                child: const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                                  : Icon(
                                Icons.camera_alt_outlined,
                                color: Colors.white,
                                size: 20.sp,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 10.h),
                  Center(
                    child: Column(
                      children: [
                        Text(viewModel.userName ?? "Guest User",
                            style: AppStyles.medium12Primary),
                        Text(viewModel.userEmail ?? "No Email",
                            style: AppStyles.medium12Primary),
                      ],
                    ),
                  ),

                  SizedBox(height: 30.h),

                  // --- Profile Fields ---
                  _buildProfileField(
                    context: context,
                    label: "Your full name",
                    value: viewModel.userName ?? "Not Set",
                    apiKey: 'userName',
                    viewModel: viewModel,
                  ),
                  _buildProfileField(
                    context: context,
                    label: "Your E-mail",
                    value: viewModel.userEmail ?? "Not Set",
                    apiKey: 'userEmail',
                    viewModel: viewModel,
                  ),
                  _buildProfileField(
                    context: context,
                    label: "Your mobile number",
                    value: viewModel.userPhone ?? "Not Set",
                    apiKey: 'userPhone',
                    viewModel: viewModel,
                  ),
                  _buildProfileField(
                    context: context,
                    label: "Your Address",
                    value: "6th October, street 11...",
                    apiKey: 'userAddress', // اختياري لو كنت تحفظ العنوان
                    viewModel: viewModel,
                  ),

                  SizedBox(height: 20.h),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // دالة الحقل (Widget) مع إضافة الـ Context والأيقونة القابلة للضغط
  Widget _buildProfileField({
    required BuildContext context,
    required String label,
    required String value,
    required String apiKey,
    required UserTabViewModel viewModel,
    bool isPassword = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppStyles.medium12Primary),
          SizedBox(height: 8.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColors.primaryColor.withOpacity(0.2)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    value,
                    style: AppStyles.medium12Primary.copyWith(color: Colors.black87),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  onPressed: () => _showEditDialog(context, viewModel, label, apiKey, value),
                  icon: Icon(Icons.edit_outlined, color: AppColors.primaryColor, size: 20.sp),
                  constraints: const BoxConstraints(), // لتقليل مساحة الزر
                  padding: EdgeInsets.zero,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // دالة إظهار نافذة التعديل
  void _showEditDialog(BuildContext context, UserTabViewModel viewModel, String title, String key, String currentValue) {
    TextEditingController controller = TextEditingController(text: currentValue);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit $title", style: AppStyles.medium14Primary),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: "Enter new $title",
            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.primaryColor)),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryColor),
            onPressed: () {
              viewModel.updateUserData(key: key, newValue: controller.text);
              Navigator.pop(context);
            },
            child: const Text("Update", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}