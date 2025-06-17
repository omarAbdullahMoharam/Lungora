// ignore_for_file: use_build_context_synchronously

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
  String? _cachedName;
  String? _cachedImagePath;

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

    setState(() {
      _cachedName = cachedName;
      _cachedImagePath = cachedImage;
      userNameController.text = cachedName ?? "";
      _selectedImage = (cachedImage != null && !cachedImage.startsWith("https"))
          ? File(cachedImage)
          : null;
    });

    // استدعاء الـ API
    final token = await SecureStorageService.getToken();
    if (token != null) {
      BlocProvider.of<SettingsCubit>(context).getUserData(token: token);
    }
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
          _cachedName = state.userModel.fullName;
          _cachedImagePath = state.userModel.imageUser;
          await SecureStorageService.saveUserName(state.userModel.fullName);
          await SecureStorageService.saveUserImage(state.userModel.imageUser);
          setState(() {}); // علشان تحدث القيم في الـ UI
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
                      : _cachedImagePath,
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
                      : _cachedName ?? '',
                ),
                SizedBox(height: 24.h),
                CustomElevatedButton(
                  text: 'Confirm',
                  isLoading: state is SettingsLoading,
                  onPressed: () async {
                    final token = await SecureStorageService.getToken();
                    final cachedName = await SecureStorageService.getUserName();
                    final cachedImage =
                        await SecureStorageService.getUserImage();

                    final isNameChanged = userNameController.text.trim() !=
                        (cachedName ?? "").trim();
                    final isImageChanged =
                        (_selectedImage?.path ?? "") != (cachedImage ?? "");

                    if (!isNameChanged && !isImageChanged) {
                      SnackBarHandler.showError(
                          "Please modify your name or image before saving.");
                      return;
                    }

                    if (token != null) {
                      if (isNameChanged) {
                        await SecureStorageService.saveUserName(
                            userNameController.text.trim());
                      }
                      if (isImageChanged) {
                        await SecureStorageService.saveUserImage(
                            _selectedImage?.path ?? "");
                      }

                      BlocProvider.of<SettingsCubit>(context).editInfo(
                        token: token,
                        username: userNameController.text.trim(),
                        image: _selectedImage,
                      );
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
