import 'package:flutter/material.dart';

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
        return OTPDialog(
          email: email,
        );
      },
    );
  }
}
