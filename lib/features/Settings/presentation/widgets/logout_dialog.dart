// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lungora/core/constants.dart';
import 'package:lungora/core/helpers/api_services.dart';
import 'package:lungora/core/utils/app_router.dart';
import 'package:lungora/core/utils/custom_loading_indicator.dart';
import 'package:lungora/core/utils/custom_snackbar.dart';
import 'package:lungora/core/utils/dependency_injection.dart';
import 'package:lungora/core/utils/styles.dart';
import 'package:lungora/features/Settings/data/view_model/settings_cubit/settings_cubit.dart';
import 'package:lungora/features/auth/services/secure_storage_service.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  void _exitApp(BuildContext context) {
    // Navigator.of(context).pop();
    Future.delayed(Duration(milliseconds: 300), () {
      GoRouter.of(context).go(AppRouter.kAuthView);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsCubit(
        // Change the SettingsCubit to the one in the data layer
        getIt<ApiServices>(),
      ),
      child: BlocConsumer<SettingsCubit, SettingsState>(
        listener: (context, state) {
          if (state is SettingsFailure) {
            SnackBarHandler.showError(state.errMessage);
          }
          if (state is SettingsSuccess) {
            // SnackBarHandler.showSuccess(state.message);
            // Clear the storage after successful logout
            SecureStorageService.deleteAll();
            _exitApp(context);
            // Future.delayed(Duration(milliseconds: 300), () {
            //   _exitApp(context);
            // });
          }
        },
        builder: (context, state) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.h),
            ),
            contentPadding: EdgeInsets.all(20.w),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.power_settings_new,
                  size: 50.sp,
                  color: kSecondaryColor,
                ),
                SizedBox(height: 16.h),
                Text(
                  "Logout",
                  textAlign: TextAlign.center,
                  style: Styles.textStyle20,
                ),
                SizedBox(height: 8.h),
                Text(
                  "Are you sure you want to logout?",
                  style: Styles.textStyle14,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 32.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        try {
                          // Show loading indicator
                          // Get token from secure storage
                          String? token = await SecureStorageService.getToken();

                          if (token == null) {
                            // Handle case where token is missing
                            log('Token is null - user already logged out');
                            GoRouter.of(context).go(AppRouter.kAuthView);
                            return;
                          }

                          // Call logout with proper token
                          await BlocProvider.of<SettingsCubit>(context)
                              .logout(token: token);

                          // Clear the storage after successful logout
                          await SecureStorageService.deleteAll();

                          // Navigate to login page instead of exiting
                          GoRouter.of(context).go(AppRouter.kAuthView);
                        } catch (e) {
                          log('Error during logout: $e');
                          // Show error message to user
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                                    'Failed to logout. Please try again.')),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kSecondaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.h),
                        ),
                      ),
                      child: state is SettingsLoading
                          ? CustomLoadingIndicator()
                          : Text(
                              "Confirm",
                              style: Styles.textStyleInter16
                                  .copyWith(color: Colors.white),
                            ),
                    ),
                    SizedBox(width: 10.w),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.h),
                        ),
                      ),
                      child: Text("Cancel"),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
