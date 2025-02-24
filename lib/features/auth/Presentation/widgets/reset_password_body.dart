import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lungora/core/constants.dart';
import 'package:lungora/core/utils/app_roture.dart';
import 'package:lungora/core/utils/styles.dart';
import 'package:lungora/features/Auth/Presentation/widgets/custom_text_form_field.dart';
import 'package:lungora/features/auth/Presentation/widgets/custom_password_appbar.dart';

import 'show_success_dialog.dart' show SuccessDialog;

class ResetPasswordBody extends StatefulWidget {
  // final String email;
  // final String otp;

  const ResetPasswordBody({
    super.key,
    // required this.email,
    // required this.otp,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ResetPasswordBodyState createState() => _ResetPasswordBodyState();
}

class _ResetPasswordBodyState extends State<ResetPasswordBody> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

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

  String? validateConfirmPassword(String? value) {
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  void _onConfirm() {
    if (_formKey.currentState!.validate()) {
      SuccessDialog.show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 23.w, vertical: 76.h),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomPasswordAppBar(
                text: 'Reset Password',
                onPressed: () {
                  GoRouter.of(context).go(AppRoture.kLoginView);
                },
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
              CustomTextFormField(
                labelText: 'New Password',
                isPassword: true,
                controller: _passwordController,
                hintText: 'New Password',
                suffixIcon: Icons.lock_clock_outlined,
                prefixIcon: Icons.remove_red_eye,
                autoSuggest: false,
                validator: validatePassword,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Text(
                  'Your password must be 8 or more characters long & contain upper & lower case letters, numbers, and a special character.',
                  style: Styles.textStyle12,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
              CustomTextFormField(
                labelText: 'Confirm Password',
                isPassword: true,
                controller: _confirmPasswordController,
                hintText: 'Confirm Password',
                suffixIcon: Icons.lock_clock_outlined,
                prefixIcon: Icons.remove_red_eye,
                autoSuggest: false,
                validator: validateConfirmPassword,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
              ElevatedButton(
                onPressed: _onConfirm,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.w),
                  ),
                  minimumSize: Size(1.sw, 60.h),
                  backgroundColor: kPrimaryColor,
                ),
                child: Text(
                  'Confirm',
                  style: Styles.textStyle20.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
