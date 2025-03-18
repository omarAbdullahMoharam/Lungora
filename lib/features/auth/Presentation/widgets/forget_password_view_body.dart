import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lungora/core/constants.dart';
import 'package:lungora/core/utils/custom_loading_indicator.dart';
import 'package:lungora/core/utils/custom_snackbar.dart';
import 'package:lungora/core/utils/app_router.dart';
import 'package:lungora/core/utils/custom_appbar.dart';
import 'package:lungora/core/utils/dependency_injection.dart';
import 'package:lungora/core/utils/styles.dart';
import 'package:lungora/features/Auth/Presentation/view_models/auth_cubit/auth_cubit.dart';
import 'package:lungora/features/Auth/Presentation/widgets/custom_text_form_field.dart';
import 'package:lungora/features/Auth/Presentation/widgets/show_otp_dialog.dart';
import 'package:lungora/features/Auth/data/repos/auth_repo.dart';

class ForgetPasswordViewBody extends StatefulWidget {
  const ForgetPasswordViewBody({
    super.key,
    this.onPressed,
  });
  final void Function(BuildContext context)? onPressed;
  @override
  State<ForgetPasswordViewBody> createState() => _ForgetPasswordViewBodyState();
}

class _ForgetPasswordViewBodyState extends State<ForgetPasswordViewBody> {
  final TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(getIt<AuthRepo>()),
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            SnackBarHandler.showError(
              'Error: ${state.errMessage}',
            );
          } else if (state is AuthSuccess) {
            SnackBarHandler.showSuccess(
              'OTP sent to ${emailController.text}',
            );
            Future.delayed(const Duration(seconds: 3), () {});

            ShowOtpDialog.showOtpDialog(
              context: context,
              email: emailController.text,
            );
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 76.h),
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                CustomAppBar(
                  text: 'Forget Password',
                  onPressed: () {
                    GoRouter.of(context).go(AppRouter.kAuthView);
                  },
                ),
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
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<AuthCubit>(context)
                              .forgetUserPassword(
                            email: emailController.text,
                          );
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
                      child: state is AuthLoading?
                          CustomLoadingIndicator()
                          : Text(
                              'Contenue',
                              style: Styles.textStyle20.copyWith(
                                color: Colors.white,
                              ),
                            ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
