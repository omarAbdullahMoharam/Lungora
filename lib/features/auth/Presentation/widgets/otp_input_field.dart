import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:lungora/core/constants.dart';

class OTPInputField extends StatelessWidget {
  final TextEditingController controller;

  const OTPInputField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      length: 4,
      controller: controller,
      onChanged: (value) {},
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(16.h),
        fieldHeight: 55.h,
        fieldWidth: 55.w,
        activeColor: kSecondaryColor,
        selectedColor: kPrimaryColor,
        inactiveColor: kPrimaryColor,
      ),
      keyboardType: TextInputType.number,
    );
  }
}
