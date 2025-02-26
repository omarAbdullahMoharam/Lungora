import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lungora/core/utils/dependency_injection.dart';
import 'package:lungora/features/Auth/Presentation/view_models/auth/auth_cubit.dart';
import 'package:lungora/features/Auth/data/repos/auth_repo.dart';
import 'package:lungora/features/auth/Presentation/widgets/reset_password_body.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({
    super.key,
    required this.email,
    required this.otp,
  });
  final String email;
  final String otp;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(getIt<AuthRepo>()),
      child: Scaffold(
        body: ResetPasswordBody(
          email: email,
          otp: otp,
        ),
      ),
    );
  }
}
