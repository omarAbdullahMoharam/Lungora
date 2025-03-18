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

  @override
  void dispose() {
    userNameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loadCachedUserData();
  }

  /// تحميل البيانات المخزنة في الكاش
  void _loadCachedUserData() async {
    String? cachedName = await SecureStorageService.getUserName();
    String? cachedImage = await SecureStorageService.getUserImage();

    if (cachedName != null || (cachedImage != null && cachedImage.isNotEmpty)) {
      setState(() {
        userNameController.text = cachedName ?? "";
        _selectedImage = (cachedImage != null && !cachedImage.startsWith("https"))
            ? File(cachedImage)
            : null;
      });
    }

    // تحميل البيانات من الـ API لو الكاش غير متاح
    SecureStorageService.getToken().then((token) {
      if (token != null) {
        BlocProvider.of<SettingsCubit>(context).getUserData(token: token);
      }
    });
  }

  void _updateSelectedImage(File? image) {
    setState(() {
      _selectedImage = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsCubit, SettingsState>(
      listener: (context, state) async {
        if (state is SettingsSuccess) {
          SnackBarHandler.showSuccess(state.message);
        } else if (state is SettingsFailure) {
          SnackBarHandler.showError(state.errMessage);
        } else if (state is SettingsGetUserDataSuccess) {
          // حفظ البيانات في التخزين المؤقت (بدون setState هنا)
          await SecureStorageService.saveUserName(state.userModel.fullName);
          await SecureStorageService.saveUserImage(state.userModel.imageUser);
        }
      },
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 70.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomAppBar(
                  text: "Edit Profile",
                  onPressed: () {
                    GoRouter.of(context).go(AppRouter.kSettingsView);
                  },
                ),
                EditProfileImage(
                  onImageSelected: _updateSelectedImage,
                  imageUrl: state is SettingsGetUserDataSuccess
                      ? state.userModel.imageUser
                      : null,
                ),
                CustomTextFormField(
                  labelText: 'Username',
                  isPassword: false,
                  controller: userNameController,
                  prefixIcon: Icons.person,
                  hintText: 'Username',
                  autoSuggest: false,
                  initialValue: state is SettingsGetUserDataSuccess
                      ? state.userModel.fullName
                      : '',
                ),
                SizedBox(height: 24.h),
                CustomElevatedButton(
                  text: 'Confirm',
                  isLoading: state is SettingsLoading,
                  onPressed: () async {
                    if (userNameController.text.isEmpty &&
                        _selectedImage == null) {
                      return;
                    }

                    try {
                      final token = await SecureStorageService.getToken();
                      if (token != null&&userNameController.text.isNotEmpty && _selectedImage != null) {

                        await SecureStorageService.saveUserName(userNameController.text);
                        await SecureStorageService.saveUserImage(_selectedImage?.path ?? "");
                       setState(() {
                         
                       });
                        BlocProvider.of<SettingsCubit>(context).editInfo(
                          token: token,
                          username: userNameController.text,
                          image: _selectedImage,
                        );
                      }
                    } catch (e) {
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
