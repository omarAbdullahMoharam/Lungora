// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lungora/core/constants.dart';
import 'package:lungora/core/helpers/user_name_service.dart';
import 'package:lungora/core/helpers/user_profile_service.dart';
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

  String _currentDisplayedName = '';
  String _currentDisplayedImageUrl = '';
  File? _selectedImage;
  bool _isInitializing = true;

  @override
  void dispose() {
    userNameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initializeProfileData();
  }

  void _initializeProfileData() async {
    setState(() {
      _isInitializing = true;
    });

    try {
      await Future.wait([
        _loadProfileName(),
        _loadProfileImage(),
      ]);
    } catch (e) {
      _currentDisplayedName = ProfileNameService.defaultName;
      _currentDisplayedImageUrl = ProfileImageService.defaultImage;
      userNameController.text = _currentDisplayedName;
    } finally {
      setState(() {
        _isInitializing = false;
      });
    }
  }

  Future<void> _loadProfileName() async {
    try {
      String name = await ProfileNameService.getProfileName(context);
      setState(() {
        _currentDisplayedName = name;
        userNameController.text = name;
      });
    } catch (e) {
      setState(() {
        _currentDisplayedName = ProfileNameService.defaultName;
        userNameController.text = _currentDisplayedName;
      });
    }
  }

  Future<void> _loadProfileImage() async {
    try {
      String imageUrl = await ProfileImageService.getProfileImage(context);
      setState(() {
        _currentDisplayedImageUrl = imageUrl;
        if (imageUrl.isNotEmpty && !imageUrl.startsWith('http')) {
          _selectedImage = File(imageUrl);
        }
      });
    } catch (e) {
      setState(() {
        _currentDisplayedImageUrl = ProfileImageService.defaultImage;
      });
    }
  }

  void _updateSelectedImage(File? image) {
    setState(() {
      _selectedImage = image;
    });
  }

  bool _hasChanges() {
    final isNameChanged =
        userNameController.text.trim() != _currentDisplayedName.trim();
    final isImageChanged = _selectedImage != null &&
        _selectedImage!.path != _currentDisplayedImageUrl;
    return isNameChanged || isImageChanged;
  }

  Future<void> _saveChanges() async {
    if (!_hasChanges()) {
      SnackBarHandler.showError(
          "Please modify your name or image before saving.");
      return;
    }

    final token = await SecureStorageService.getToken();
    if (token == null) {
      SnackBarHandler.showError("Authentication required. Please login again.");
      return;
    }

    final newName = userNameController.text.trim();
    if (newName != _currentDisplayedName.trim()) {
      ProfileNameService.updateProfileName(newName);
      setState(() {
        _currentDisplayedName = newName;
      });
    }

    if (_selectedImage != null) {
      ProfileImageService.updateProfileImage(_selectedImage!.path);
      setState(() {
        _currentDisplayedImageUrl = _selectedImage!.path;
      });
    }

    BlocProvider.of<SettingsCubit>(context).editInfo(
      token: token,
      username: newName,
      image: _selectedImage,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsCubit, SettingsState>(
      listener: (context, state) async {
        if (state is SettingsSuccess) {
          SnackBarHandler.showSuccess(state.message);
          _initializeProfileData();
        } else if (state is SettingsFailure) {
          SnackBarHandler.showError(state.errMessage);
        } else if (state is SettingsGetUserDataSuccess) {
          ProfileNameService.updateProfileName(state.userModel.fullName);
          ProfileImageService.updateProfileImage(state.userModel.imageUser);

          setState(() {
            _currentDisplayedName = state.userModel.fullName;
            _currentDisplayedImageUrl = state.userModel.imageUser;
            userNameController.text = state.userModel.fullName;

            if (state.userModel.imageUser.isNotEmpty &&
                !state.userModel.imageUser.startsWith('http')) {
              _selectedImage = File(state.userModel.imageUser);
            }
          });
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
                _buildImageSection(),
                SizedBox(height: 20.h),
                _buildNameSection(),
                SizedBox(height: 24.h),
                CustomElevatedButton(
                  text: 'Confirm',
                  isLoading: state is SettingsLoading,
                  onPressed: _saveChanges,
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

  Widget _buildImageSection() {
    return Stack(
      alignment: Alignment.center,
      children: [
        EditProfileImage(
          onImageSelected: _updateSelectedImage,
          imageUrl: _isInitializing ? '' : _currentDisplayedImageUrl,
        ),
        if (_isInitializing)
          Container(
            width: 120.w,
            height: 120.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black.withOpacity(0.3),
            ),
            child: Center(
              child: SizedBox(
                width: 40.w,
                height: 40.w,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    kPrimaryColor,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildNameSection() {
    return Stack(
      children: [
        CustomTextFormField(
          labelText: 'Username',
          isPassword: false,
          controller: userNameController,
          prefixIcon: Icons.person,
          hintText: _isInitializing ? 'Loading...' : 'Username',
          autoSuggest: false,
          initialValue: _isInitializing ? '' : _currentDisplayedName,
        ),
        if (_isInitializing)
          Positioned.fill(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 2.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: kPrimaryColor.withOpacity(0.5),
                  width: 2,
                ),
                color: Colors.white.withOpacity(0.8),
              ),
              child: Center(
                child: SizedBox(
                  width: 20.w,
                  height: 20.w,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      kPrimaryColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
