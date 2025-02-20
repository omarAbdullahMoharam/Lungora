import 'package:flutter/material.dart';

import 'otp_view_body.dart';

class ShowOtpDialog {
  static void showOTPDialog({
    required BuildContext context,
    required String email,
    required Function(String) onVerify,
  }) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return OTPDialog(onVerify: onVerify, email: email);
      },
    );
  }
}
