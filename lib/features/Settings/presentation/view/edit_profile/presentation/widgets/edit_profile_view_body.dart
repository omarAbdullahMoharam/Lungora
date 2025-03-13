// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lungora/core/constants.dart';
import 'package:lungora/core/utils/app_router.dart';
import 'package:lungora/core/utils/custom_appbar.dart';
import 'package:lungora/core/utils/custom_elevated_button.dart';
import 'package:lungora/core/utils/custom_snackbar.dart';
import 'package:lungora/features/Auth/Presentation/widgets/custom_text_form_field.dart';
import 'package:lungora/features/Settings/data/view_model/settings_cubit/settings_cubit.dart';
import 'package:lungora/features/Settings/presentation/view/edit_profile/presentation/widgets/edit_profile_image.dart';
import 'package:lungora/features/auth/services/secure_storage_service.dart';

class EditProfileViewBody extends StatefulWidget {
  const EditProfileViewBody({super.key});

  @override
  State<EditProfileViewBody> createState() => _EditProfileViewBodyState();
}

class _EditProfileViewBodyState extends State<EditProfileViewBody> {
  TextEditingController userNameController = TextEditingController();
  File? _selectedImage;

  void _updateSelectedImage(File? image) {
    setState(() {
      _selectedImage = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsCubit, SettingsState>(
      listener: (context, state) {
        if (state is SettingsSuccess) {
          SnackBarHandler.showSuccess(state.message);
        } else if (state is SettingsFailure) {
          SnackBarHandler.showError(state.errMessage);
        }
      },
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 70.h,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomAppBar(
                    text: "Edit Profile",
                    onPressed: () {
                      GoRouter.of(context).go(AppRouter.kSettingsView);
                    }),
                EditProfileImage(onImageSelected: _updateSelectedImage),
                CustomTextFormField(
                  labelText: 'Username',
                  isPassword: false,
                  controller: userNameController,
                  prefixIcon: Icons.person,
                  hintText: 'Username',
                  autoSuggest: false,
                ),
                SizedBox(height: 24.h),
                CustomElevatedButton(
                  text: 'Confirm',
                  isLoading: state is SettingsLoading,
                  onPressed: () async {
                    // Validate that at least one field is being updated
                    if (userNameController.text.isEmpty &&
                        _selectedImage == null) {
                      // Show an error or return if no changes
                      return;
                    }

                    try {
                      // Get the token
                      final token = await SecureStorageService.getToken();

                      BlocProvider.of<SettingsCubit>(context).editInfo(
                        token: token!,
                        username: userNameController.text,
                        image: _selectedImage,
                      );
                      // GoRouter.of(context).go(AppRouter.kSettingsView);
                    } catch (e) {
                      // Handle any errors
                      log('Error updating user info: $e');
                    }
                  },
                  backgroundColor: kPrimaryColor,
                  height: 60,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
