import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SnackBarHandler {
  static void showSnackBar({
    required String message,
    bool isError = false,
    Duration duration = const Duration(seconds: 3),
  }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength:
          duration.inSeconds > 2 ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: duration.inSeconds,
      backgroundColor: isError ? Colors.red : Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  // Helper methods for success/error messages:
  static void showSuccess(String message) {
    showSnackBar(message: message, isError: false);
  }

  static void showError(String message) {
    showSnackBar(message: message, isError: true);
  }
}
