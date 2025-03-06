import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lungora/core/constants.dart';
import 'package:lungora/core/utils/custom_snackbar.dart';
import 'package:lungora/core/utils/styles.dart';
import 'package:lungora/features/auth/Presentation/view_models/auth_cubit/auth_cubit.dart';
import 'package:lungora/features/auth/Presentation/widgets/custom_text_form_field.dart';

class ChangePasswordForm extends StatelessWidget {
  const ChangePasswordForm({
    super.key,
    required this.emailController,
    required this.formKey,
    required this.onPressed,
  });
  final void Function()? onPressed;
  final TextEditingController emailController;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 8.h),
        Text(
          'Don’t worry! It happens. Please enter your email and we’ll send OTP to your email',
          style: Styles.textStyleInter16.copyWith(
            color: const Color.fromRGBO(119, 119, 119, 1),
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 32.h),
        CustomTextFormField(
          autoSuggest: true,
          labelText: 'Email',
          isPassword: false,
          prefixIcon: Icons.email,
          hintText: 'Email',
          controller: emailController,
          validator: (value) {
            if (value!.isEmpty) {
              return "Please enter your email";
            } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                .hasMatch(value)) {
              return "Please enter a valid email";
            }
            return null;
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
          child: BlocProvider.of<AuthCubit>(context).state is AuthLoading
              ? CircularProgressIndicator(
                  color: Colors.white,
                )
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
