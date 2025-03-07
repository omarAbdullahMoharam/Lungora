import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lungora/core/utils/custom_snackbar.dart';
import 'package:lungora/core/utils/app_router.dart';
import 'package:lungora/core/utils/custom_appbar.dart';
import 'package:lungora/features/Auth/Presentation/view_models/auth_cubit/auth_cubit.dart';
import 'package:lungora/features/Auth/Presentation/widgets/show_otp_dialog.dart';
import 'package:lungora/features/auth/Presentation/widgets/forget_password_form.dart';

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
    return BlocListener<AuthCubit, AuthState>(
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
              ForgetPasswordForm(
                onPressed: () {
                  BlocProvider.of<AuthCubit>(context).forgetUserPassword(
                    email: emailController.text,
                  );
                },
                emailController: emailController,
                formKey: formKey,
              )
            ],
          ),
        ),
      ),
    );
  }
}
