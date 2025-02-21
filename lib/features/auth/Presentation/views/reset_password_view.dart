import 'package:flutter/material.dart';
import 'package:lungora/features/auth/Presentation/widgets/reset_password_body.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key, required this.email, required this.otp});
  final String email;
  final String otp;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: ResetPasswordBody(
        email: email,
        otp: otp,
      ),
    ));
  }
}
