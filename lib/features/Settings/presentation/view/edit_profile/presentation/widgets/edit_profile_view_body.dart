import 'dart:convert';
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
  String UserName = '';
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
        // TODO: implement listener

        if (state is SettingsSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: kPrimaryColor,
            ),
          );
        } else if (state is SettingsFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              // content: Text('Failed to edit profile'),
              content: Text(state.errMessage),
              backgroundColor: Colors.red,
            ),
          );
          // SnackBarHandler.showError('Failed to edit profile');
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
                  text: state is SettingsLoading ? 'Loading...' : 'Confirm',
                  onPressed: () async {
                    // Validate that at least one field is being updated
                    if (userNameController.text.isEmpty &&
                        _selectedImage == null) {
                      // Show an error or return if no changes
                      return;
                    }

                    // Convert image file to base64 string if it exists
                    String? base64Image;
                    if (_selectedImage != null) {
                      final bytes = await _selectedImage!.readAsBytes();
                      base64Image = base64Encode(bytes);
                    }

                    try {
                      // Get the token
                      final token = await SecureStorageService.getToken();

                      // Prepare the request body
                      UserName = userNameController.text;
                      BlocProvider.of<SettingsCubit>(context).editInfo(
                        token: token!,
                        username: UserName,
                        image: base64Image,
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
