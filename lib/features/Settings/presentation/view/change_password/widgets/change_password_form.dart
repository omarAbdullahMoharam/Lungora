import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lungora/core/constants.dart';
import 'package:lungora/core/utils/custom_loading_indicator.dart';
import 'package:lungora/core/utils/custom_snackbar.dart';
import 'package:lungora/core/utils/styles.dart';
import 'package:lungora/features/Settings/data/view_model/settings_cubit/settings_cubit.dart';
import 'package:lungora/features/auth/Presentation/widgets/custom_text_form_field.dart';

class ChangePasswordForm extends StatelessWidget {
  const ChangePasswordForm({
    super.key,
    required this.newPassController,
    required this.currentPassController,
    required this.formKey,
    required this.onPressed,
  });
  final void Function()? onPressed;
  final TextEditingController newPassController;
  final TextEditingController currentPassController;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 32.h),
        CustomTextFormField(
          autoSuggest: true,
          labelText: 'Current Password',
          isPassword: true,
          prefixIcon: Icons.lock,
          hintText: 'Current Password',
          controller: currentPassController,
          validator: (value) {
            validatePassword(value);
            return null;
          },
          onChanged: (value) {
            validatePassword(value);
          },
        ),
        SizedBox(height: 32.h),
        CustomTextFormField(
          autoSuggest: true,
          labelText: 'New Password',
          isPassword: true,
          needHelper: true,
          prefixIcon: Icons.lock,
          hintText: 'New Password',
          controller: newPassController,
          validator: (value) {
            validatePassword(value);
            return null;
          },
          onChanged: (value) {
            validatePassword(value);
          },
        ),
        SizedBox(height: 32.h),
        ElevatedButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              onPressed!();
            } else {
              log('Error!  Please enter a valid email');
              SnackBarHandler.showError(
                'Error!  Please enter a valid email',
              );
            }
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.w),
            ),
            minimumSize: Size(1.sw, 60.h),
            backgroundColor: kPrimaryColor,
          ),
          child:
              BlocProvider.of<SettingsCubit>(context).state is SettingsLoading
                  ? CustomLoadingIndicator()
                  : Text(
                      'Contenue',
                      style: Styles.textStyle20.copyWith(
                        color: Colors.white,
                      ),
                    ),
        ),
      ],
    );
  }
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Password is required';
  }
  if (value.length < 8) {
    return 'Password must be at least 8 characters long';
  }
  if (!RegExp(r'(?=.*[A-Z])').hasMatch(value)) {
    return 'Password must contain at least one uppercase letter';
  }
  if (!RegExp(r'(?=.*[a-z])').hasMatch(value)) {
    return 'Password must contain at least one lowercase letter';
  }
  if (!RegExp(r'(?=.*\d)').hasMatch(value)) {
    return 'Password must contain at least one number';
  }
  if (!RegExp(r'(?=.[@$!%?&])').hasMatch(value)) {
    return 'Password must contain at least one special character (@\$!%*?&)';
  }
  return null;
}
