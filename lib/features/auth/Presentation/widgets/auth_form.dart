import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lungora/core/constants.dart';
import 'package:lungora/core/utils/app_roture.dart';
import 'package:lungora/core/utils/styles.dart';
import 'package:lungora/features/Auth/Presentation/widgets/custom_text_form_field.dart';
import 'package:lungora/features/Auth/Presentation/widgets/social_auth_section.dart';

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
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool rememberMe = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 23.w),
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _formKey,
        child: Column(
          children: <Widget>[
            if (!widget.isLogin) ...[
              CustomTextFormField(
                labelText: 'Username',
                isPassword: false,
                prefixIcon: Icons.person,
                hintText: 'Username',
                controller: usernameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter your username";
                  }
                  return null;
                },
              ),
              SizedBox(height: 24.h),
            ],
            CustomTextFormField(
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
            SizedBox(height: 24.h),
            CustomTextFormField(
              labelText: 'Password',
              isPassword: true,
              prefixIcon: Icons.lock,
              hintText: 'Password',
              suffixIcon: Icons.remove_red_eye_rounded,
              controller: passwordController,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter your password";
                } else if (value.length < 8) {
                  return "Password must be at least 8 characters";
                }
                return null;
              },
            ),
            if (!widget.isLogin) ...[
              SizedBox(height: 16.h),
              CustomTextFormField(
                labelText: 'Confirm Password',
                isPassword: true,
                prefixIcon: Icons.lock,
                hintText: 'Confirm Password',
                suffixIcon: Icons.remove_red_eye_rounded,
                controller: confirmPasswordController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please confirm your password";
                  } else if (value != passwordController.text) {
                    return "Passwords do not match";
                  }
                  return null;
                },
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
                      style: Styles.textStyle12.copyWith(
                        color: Colors.black.withValues(alpha: 0.5),
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
                      onPressed: () {
                        context.go(AppRoture.kForgetPassView);
                      },
                      child: Text(
                        'Forgot Password?',
                        style: Styles.textStyle12.copyWith(color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            ],
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  if (widget.isLogin) {
                    context.go(AppRoture.kHomeView);
                  } else {}
                }
              },
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
      ),
    );
  }
}
