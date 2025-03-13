// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lungora/core/utils/app_router.dart';
import 'package:lungora/core/utils/custom_appbar.dart';
import 'package:lungora/core/utils/custom_snackbar.dart';
import 'package:lungora/features/Settings/data/view_model/settings_cubit/settings_cubit.dart';
import 'package:lungora/features/Settings/presentation/view/change_password/widgets/change_password_form.dart';
import 'package:lungora/features/auth/services/secure_storage_service.dart';

class ChangePasswordViewBody extends StatefulWidget {
  const ChangePasswordViewBody({super.key});

  @override
  State<ChangePasswordViewBody> createState() => _ChangePasswordViewBodyState();
}

class _ChangePasswordViewBodyState extends State<ChangePasswordViewBody> {
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsCubit, SettingsState>(
      listener: (context, state) {
        if (state is SettingsFailure) {
          SnackBarHandler.showError(
            'Error: ${state.errMessage}',
          );
        } else if (state is SettingsSuccess) {
          SnackBarHandler.showSuccess(
            ' Success: ${state.message}',
          );
          Future.delayed(const Duration(seconds: 3), () {});

          GoRouter.of(context).go(AppRouter.kSettingsView);
        }
      },
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 76.h),
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
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
                    currentPassController: currentPasswordController,
                    newPassController: newPasswordController,
                    formKey: formKey,
                    onPressed: () async {
                      formKey.currentState!.save();
                      if (!formKey.currentState!.validate()) {
                        return;
                      }
                      final token = await SecureStorageService.getToken();
                      if (token == null) {
                        GoRouter.of(context).go(AppRouter.kAuthView);
                        return;
                      }

                      BlocProvider.of<SettingsCubit>(context).changePassword(
                        currentPasswordController.text,
                        newPasswordController.text,
                        token,
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
