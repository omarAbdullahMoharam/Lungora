import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lungora/features/Auth/Presentation/widgets/custom_text_form_field.dart';
import 'package:lungora/features/Home/presentation/widgets/show_otp_dialog.dart';
import '../../../../core/constants.dart';
import '../../../../core/utils/styles.dart';
import 'custom_password_appbar.dart';

class ForgetPasswordViewBody extends StatefulWidget {
  const ForgetPasswordViewBody({super.key});

  @override
  State<ForgetPasswordViewBody> createState() => _ForgetPasswordViewBodyState();
}

class _ForgetPasswordViewBodyState extends State<ForgetPasswordViewBody> {
  final TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 76.h),
      child: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            CustomPasswordAppBar(
              text: 'Forget Password',
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
            ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    // BlocProvider.of<AuthCubit>(context).forgetPassword(emailController.text);
                    // Navigator.pushNamed(context, AppRoture.);
                    // Navigate to OTP Screen with email as argument
                    // @amera612
                    // @omarAbdullahMoharam🚔📢

                    if (formKey.currentState!.validate()) {
                      return ShowOtpDialog.showOTPDialog(
                        context: context,
                        email: emailController.text,
                        onVerify: (otp) {
                          if (otp == '1234') {
                            log('OTP is $otp');
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('OTP is $otp'),
                              ),
                            );
                          }
                          // BlocProvider.of<AuthCubit>(context).verifyOTP(emailController.text, otp);
                          // Navigator.pop(context);
                          // GoRouter.of(context).go('/resetPassword');
                        },
                      );
                    } else {
                      debugPrint('Error'
                          'Please enter a valid email');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Please enter a valid email'),
                        ),
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.w),
                  ),
                  minimumSize: Size(1.sw, 60.h),
                  backgroundColor: kPrimaryColor,
                ),
                child: Text(
                  'Contenue',
                  style: Styles.textStyle20.copyWith(
                    color: Colors.white,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
