import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lungora/core/utils/app_router.dart';
import 'package:lungora/core/utils/custom_appbar.dart';
import 'package:lungora/core/utils/custom_snackbar.dart';
import 'package:lungora/features/Settings/presentation/widgets/change_password/widgets/change_password_form.dart';
import 'package:lungora/features/auth/Presentation/view_models/auth/auth_cubit.dart';
import 'package:lungora/features/auth/Presentation/widgets/show_otp_dialog.dart';

class ChangePasswordViewBody extends StatefulWidget {
  const ChangePasswordViewBody({super.key});

  @override
  State<ChangePasswordViewBody> createState() => _ChangePasswordViewBodyState();
}

class _ChangePasswordViewBodyState extends State<ChangePasswordViewBody> {
  final TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
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
        if (state is AuthLoading) {
          CircularProgressIndicator();
        }
      },
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 76.h),
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                CustomAppBar(
                  text: 'Change Password',
                  onPressed: () {
                    // Navigate to change password screen
                    GoRouter.of(context).go(AppRouter.kSettingsView);
                  },
                ),
                ChangePasswordForm(
                  emailController: emailController,
                  formKey: formKey,
                  onPressed: () {
                    BlocProvider.of<AuthCubit>(context).forgetUserPassword(
                      email: emailController.text,
                    );
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
