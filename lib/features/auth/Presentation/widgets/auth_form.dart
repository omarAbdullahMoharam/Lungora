// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lungora/core/constants.dart';
import 'package:lungora/core/helpers/custom_snackbar.dart';
import 'package:lungora/core/utils/app_router.dart';
import 'package:lungora/core/utils/styles.dart';
import 'package:lungora/features/Auth/Presentation/view_models/auth/auth_cubit.dart';
import 'package:lungora/features/Auth/Presentation/widgets/custom_text_form_field.dart';
import 'package:lungora/features/Auth/Presentation/widgets/social_auth_section.dart';
import 'package:lungora/features/auth/Presentation/view_models/auth/login_cubit/login_cubit.dart';
import 'package:lungora/features/auth/Presentation/view_models/auth/login_cubit/register_cubit/register_cubit.dart';

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
  late String name;
  late String email;
  late String password;
  late String confirmPassword;
  final _formKey = GlobalKey<FormState>();
  bool rememberMe = false;
  @override
  Widget build(BuildContext context) {
    bool needHelper = false;
    if (!widget.isLogin) {
      needHelper = true;
    }

    return MultiBlocListener(
      listeners: [
        BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              SnackBarHandler.showSuccess('Login successful');
              Future.delayed(const Duration(seconds: 1), () {
                GoRouter.of(context).pushReplacement(AppRouter.kHomeView);
              });
            } else if (state is LoginFailure) {
              log('\n${state.errMessage} from login failure');
              SnackBarHandler.showError(state.errMessage);
            } else if (state is LoginLoading) {
              CircularProgressIndicator();
            }
          },
        ),
        BlocListener<RegisterCubit, RegisterState>(
          listener: (context, state) {
            if (state is RegisterSuccess) {
              SnackBarHandler.showSuccess('Registration successful');
              Future.delayed(const Duration(seconds: 3), () {
                GoRouter.of(context).push(AppRouter.kAuthView);
              });
            } else if (state is RegisterFailure) {
              SnackBarHandler.showError('Error: ${state.errMessage}');
            }
          },
        ),
      ],
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 23.w),
            child: Form(
              autovalidateMode: AutovalidateMode.disabled,
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  if (!widget.isLogin) ...[
                    CustomTextFormField(
                      autoSuggest: true,
                      labelText: 'Username',
                      isPassword: false,
                      prefixIcon: Icons.person,
                      hintText: 'Username',
                      controller: usernameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your username";
                        }
                        name = value.trim();

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
                      value = value!.trim();
                      if (value.isEmpty) {
                        return "Please enter your email";
                      } else if (!RegExp(
                              r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                          .hasMatch(value)) {
                        return "Please enter a valid email address";
                      }
                      email = value.trim();
                      return null;
                    },
                    autoSuggest: true,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  SizedBox(height: 24.h),
                  CustomTextFormField(
                    autoSuggest: widget.isLogin ? true : false,
                    labelText: 'Password',
                    isPassword: true,
                    prefixIcon: Icons.lock,
                    hintText: 'Password',
                    suffixIcon: Icons.remove_red_eye_rounded,
                    controller: passwordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your password";
                      } else if (value.length < 9) {
                        return "Password must be at least 9 characters";
                      } else if (!widget.isLogin &&
                          !RegExp(r'^(?=.*[A-Z])(?=.*[^a-zA-Z0-9]).{8,}$')
                              .hasMatch(value)) {
                        return "Password must contain at least one uppercase letter, one number, and one special character";
                      }
                      password = value;
                      return null;
                    },
                    needHelper: needHelper,
                  ),
                  if (!widget.isLogin) ...[
                    SizedBox(height: 16.h),
                    CustomTextFormField(
                      autoSuggest: widget.isLogin ? true : false,
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
                        confirmPassword = value;

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
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            splashRadius: 16.r,
                            value: rememberMe,
                            activeColor: rememberMe
                                ? kPrimaryColor
                                : Colors.grey.shade400,
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
                              padding:
                                  WidgetStateProperty.all<EdgeInsetsGeometry>(
                                EdgeInsets.zero,
                              ),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            onPressed: () {
                              context.go(AppRouter.kForgetPassView);
                            },
                            child: Text(
                              'Forgot Password?',
                              style: Styles.textStyle12
                                  .copyWith(color: Colors.black),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  ],
                  ElevatedButton(
                    onPressed: () async {
                      FocusManager.instance.primaryFocus?.unfocus();
                      if (_formKey.currentState!.validate()) {
                        try {
                          if (widget.isLogin) {
                            log('Login request payload: email=$email, password=$password');
                            await BlocProvider.of<LoginCubit>(context).login(
                              email,
                              password,
                            );
                          } else {
                            log('Register request payload: name=$name, email=$email, password=$password');
                            await BlocProvider.of<RegisterCubit>(context)
                                .register(
                              name,
                              email.trim(),
                              password,
                              confirmPassword,
                            );
                          }
                        } catch (e) {
                          log(e.toString());
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: kSecondaryColor,
                              content: Text(
                                'An error occurred',
                                style: Styles.textStyle12
                                    .copyWith(color: Colors.black),
                              ),
                            ),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.w),
                      ),
                      minimumSize: Size(1.sw, 50.h),
                      backgroundColor: kPrimaryColor,
                    ),
                    child: BlocBuilder<RegisterCubit, RegisterState>(
                      builder: (context, state) {
                        return BlocBuilder<LoginCubit, LoginState>(
                          builder: (context, state) {
                            if (state is LoginLoading) {
                              return const CircularProgressIndicator(
                                color: Colors.white,
                              );
                            }
                            return Text(
                              widget.isLogin ? 'Login' : 'Sign up',
                              style: Styles.textStyleInter16.copyWith(
                                color: Colors.white,
                              ),
                            );
                          },
                        );
                      },
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
        },
      ),
    );
  }
}
