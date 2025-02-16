import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lungora/features/auth/Presentation/widgets/custom_text_form_field.dart';
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 67.h),
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
            labelText: 'Email',
            isPassword: false,
            prefixIcon: Icons.mail,
            hintText: 'Email',
            controller: emailController,
          ),
          SizedBox(height: 32.h),
          ElevatedButton(
              onPressed: () {},
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
              ))
        ],
      ),
    );
  }
}
