import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lungora/core/constants.dart';
import 'package:lungora/core/utils/styles.dart';

import 'otp_input_field.dart';
import 'otp_timer.dart';

class OTPDialog extends StatefulWidget {
  final Function(String) onVerify;
  final String email;

  const OTPDialog({super.key, required this.onVerify, required this.email});

  @override
  OTPDialogState createState() => OTPDialogState();
}

class OTPDialogState extends State<OTPDialog> {
  late OTPTimer _timerManager;
  TextEditingController otpController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _timerManager = OTPTimer(
      secondsRemaining: 60,
      onTick: (remainingTime) {
        if (mounted) {
          setState(() {});
        }
      },
    );
    _timerManager.startTimer();
  }

  @override
  void dispose() {
    _timerManager.dispose();

    super.dispose();
  }

  void _resendCode() {
    setState(() {
      _timerManager.resetTimer(60);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0.h),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 24.w),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * .9,
        height: MediaQuery.of(context).size.height * .4,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Verification OTP", style: Styles.textStyle20),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Text(
              "Check your mail, we've sent you the OTP to ",
              textAlign: TextAlign.center,
              style: Styles.textStyle12.copyWith(fontWeight: FontWeight.w500),
            ),
            Text(
              widget.email,
              style: Styles.textStyle14.copyWith(fontWeight: FontWeight.w500),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 16.h,
                bottom: 10.h,
                left: 8.w,
                right: 8.w,
              ),
              child: OTPInputField(controller: otpController),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: _timerManager.secondsRemaining == 0
                        ? _resendCode
                        : null,
                    child: Text("Resend your code",
                        style: Styles.textStyle14.copyWith(
                          color: _timerManager.secondsRemaining == 0
                              ? kPrimaryColor
                              : Colors.black,
                          fontFamily: 'Inter',
                        )),
                  ),
                  Text(
                    "00:${_timerManager.secondsRemaining.toString().padLeft(2, '0')}",
                    style: Styles.textStyle14,
                  ),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            ElevatedButton(
              onPressed: () {
                widget.onVerify(otpController.text);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                minimumSize: Size(1.sw, 50.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.h),
                ),
              ),
              child: Text("Verify",
                  style: Styles.textStyle16.copyWith(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
