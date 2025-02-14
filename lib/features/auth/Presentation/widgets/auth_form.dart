import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lungora/core/constants.dart';
import 'package:lungora/features/auth/Presentation/widgets/custom_text_form_field.dart';
import 'package:lungora/features/auth/Presentation/widgets/social_auth_section.dart';

class AuthForm extends StatelessWidget {
  const AuthForm({
    super.key,
    required this.isLogin,
  });

  final bool isLogin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 23.w),
      child: Column(
        children: <Widget>[
          if (!isLogin) ...[
            CustomTextFormField(
              labelText: 'Username',
              isPassword: false,
              prefixIcon: Icons.person,
              hintText: 'Username',
            ),
            SizedBox(height: 24.h),
          ],
          CustomTextFormField(
            labelText: 'Email',
            isPassword: false,
            prefixIcon: Icons.email,
            hintText: 'Email',
          ),
          SizedBox(height: 24.h),
          CustomTextFormField(
            labelText: 'Password',
            isPassword: true,
            prefixIcon: Icons.lock,
            hintText: 'Password',
            suffixIcon: Icons.remove_red_eye_rounded,
          ),
          SizedBox(height: 20.h),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.w),
              ),
              minimumSize: Size(1.sw, 50.h),
              backgroundColor: kPrimaryColor,
            ),
            child: Text(
              isLogin ? 'Login' : 'Register',
              style: const TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(height: 42.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text('Or Sign in with'),
              SizedBox(width: 8.w),
              Expanded(
                child: Divider(
                  color: Colors.black.withValues(alpha: 0.5),
                  thickness: 2,
                  height: 10.h,
                  indent: 10.w,
                  endIndent: 10.w,
                ),
              ),
            ],
          ),
          SizedBox(height: 30.h),
          SocialAuthSection(),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}
