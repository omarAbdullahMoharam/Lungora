import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lungora/core/utils/dependency_injection.dart';
import 'package:lungora/features/Auth/Presentation/view_models/auth/auth_cubit.dart';
import 'package:lungora/features/Auth/data/repos/auth_repo.dart';

import 'otp_view_body.dart';

class ShowOtpDialog {
  ShowOtpDialog();
  static void showOtpDialog({
    required BuildContext context,
    required String email,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return BlocProvider(
          create: (context) => AuthCubit(getIt<AuthRepo>()),
          child: OTPDialog(
            email: email,
          ),
        );
      },
    );
  }
}
