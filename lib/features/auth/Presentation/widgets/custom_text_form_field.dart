import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lungora/core/constants.dart';
import 'package:lungora/core/utils/styles.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.labelText,
    required this.isPassword,
    required this.controller,
    required this.prefixIcon,
    required this.hintText,
    suffixIcon,
    this.validator,
  });
  final String labelText;
  final bool isPassword;
  final String hintText;
  final TextEditingController controller;
  final IconData prefixIcon;
  final String? Function(String?)? validator;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool obscureText = true;

  IconData? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      controller: widget.controller,
      obscureText: widget.isPassword ? obscureText : false,
      decoration: InputDecoration(
        prefixIcon: Icon(
          widget.prefixIcon,
          color: kPrimaryColor,
        ),
        hintText: widget.hintText,
        hintStyle: Styles.textStyle12,
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
        labelStyle: Styles.textStyle12,
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
