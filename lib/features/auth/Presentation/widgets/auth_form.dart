import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lungora/core/constants.dart';
import 'package:lungora/features/auth/Presentation/widgets/custom_text_form_field.dart';
import 'package:lungora/features/auth/Presentation/widgets/social_auth_section.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({
    super.key,
    required this.isLogin,
  });

  final bool isLogin;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  bool rememberMe = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 23.w),
      child: Column(
        children: <Widget>[
          if (!widget.isLogin) ...[
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
          if (!widget.isLogin) ...[
            SizedBox(height: 16.h),
            CustomTextFormField(
              labelText: 'Confirm Password',
              isPassword: true,
              prefixIcon: Icons.lock,
              hintText: 'Confirm Password',
              suffixIcon: Icons.remove_red_eye_rounded,
            ),
            SizedBox(height: 24.h),
          ],
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          if (widget.isLogin) ...[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Checkbox(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    splashRadius: 16.r,
                    value: rememberMe,
                    activeColor:
                        rememberMe ? kPrimaryColor : Colors.grey.shade400,
                    onChanged: (bool? value) {
                      setState(() {
                        rememberMe = !rememberMe;
                      });
                    },
                    checkColor: Colors.white,
                  ),
                  Text(
                    'Remember me',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 12.sp,
                    ),
                  ),
                  Spacer(),
                  TextButton(
                    style: ButtonStyle(
                      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.zero,
                      ),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () {},
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Colors.black.withValues(alpha: 0.8),
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          ],
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
              widget.isLogin ? 'Login' : 'Register',
              style: const TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text('Or Sign in with'),
              SizedBox(width: 8.w),
              Expanded(
                child: Divider(
                  color: Colors.black.withValues(alpha: 0.5),
                  thickness: 1,
                  height: 10.h,
                  indent: 10.w,
                  endIndent: 10.w,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          SocialAuthSection(),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}
