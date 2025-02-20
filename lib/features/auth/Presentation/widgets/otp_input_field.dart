import 'package:flutter/material.dart';
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
        borderRadius: BorderRadius.circular(10),
        fieldHeight: 50,
        fieldWidth: 50,
        activeColor: kSecondaryColor,
        selectedColor: kPrimaryColor,
        inactiveColor: Colors.black12,
      ),
      keyboardType: TextInputType.number,
    );
  }
}
