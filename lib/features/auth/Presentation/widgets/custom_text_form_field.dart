import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lungora/core/constants.dart';

// ignore: must_be_immutable
class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    super.key,
    required this.labelText,
    required this.isPassword,
    // required this.controller,
    required this.prefixIcon,
    required this.hintText,
    suffixIcon,
  });
  final String labelText;
  final bool isPassword;
  final String hintText;
  // final TextEditingController controller;
  final IconData prefixIcon;
  IconData? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // controller: controller,
      obscureText: isPassword,

      decoration: InputDecoration(
        prefixIcon: Icon(
          prefixIcon,
          color: kPrimaryColor,
        ),
        hintText: hintText,
        suffixIcon: suffixIcon != null
            ? Icon(
                suffixIcon,
                color: kPrimaryColor,
              )
            : null,
        labelText: labelText,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: kPrimaryColor),
          borderRadius: BorderRadius.circular(10.w),
        ),
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder,
      ),
    );
  }
}

OutlineInputBorder outlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(10.w),
  borderSide: BorderSide(color: kPrimaryColor),
);
