import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lungora/core/constants.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
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

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool obscureText = true;

  IconData? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // controller: controller,
      obscureText: widget.isPassword ? obscureText : false,

      decoration: InputDecoration(
        prefixIcon: Icon(
          widget.prefixIcon,
          color: kPrimaryColor,
        ),
        hintText: widget.hintText,
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
                icon: Icon(
                  obscureText ? Icons.visibility : Icons.visibility_off,
                  color: kPrimaryColor,
                ),
              )
            : null,
        labelText: widget.labelText,
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
