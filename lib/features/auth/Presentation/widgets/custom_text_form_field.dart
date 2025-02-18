import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lungora/core/constants.dart';
import 'package:lungora/core/utils/styles.dart';

// ignore: must_be_immutable
class CustomTextFormField extends StatefulWidget {
  CustomTextFormField({
    super.key,
    required this.labelText,
    required this.isPassword,
    required this.controller,
    required this.prefixIcon,
    required this.hintText,
    this.showHelper = false,
    this.suffixIcon,
    this.validator,
    this.needHelper = false,
    required this.autoSuggest,
  });
  final bool autoSuggest;
  final bool needHelper;
  final String labelText;
  bool showHelper;
  final bool isPassword;
  final String hintText;
  final TextEditingController controller;
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final String? Function(String?)? validator;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool obscureText = true;

  late ValueNotifier<bool> lessThan8;
  late ValueNotifier<bool> hasNumber;
  late ValueNotifier<bool> hasSpecialChar;
  late ValueNotifier<bool> hasUppercase;

  @override
  void initState() {
    super.initState();
    lessThan8 = ValueNotifier(widget.controller.text.length < 9);
    hasNumber =
        ValueNotifier(widget.controller.text.contains(RegExp(r'[0-9]')));
    hasSpecialChar = ValueNotifier(
        widget.controller.text.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')));
    hasUppercase =
        ValueNotifier(widget.controller.text.contains(RegExp(r'[A-Z]')));

    widget.controller.addListener(_validatePassword);
    widget.showHelper = false;
  }

  @override
  void dispose() {
    widget.controller.removeListener(_validatePassword);
    lessThan8.dispose();
    hasNumber.dispose();
    hasSpecialChar.dispose();
    hasUppercase.dispose();
    super.dispose();
  }

  void _validatePassword() {
    lessThan8.value = widget.controller.text.length < 8;
    hasNumber.value = widget.controller.text.contains(RegExp(r'[0-9]'));
    hasSpecialChar.value =
        widget.controller.text.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    hasUppercase.value = widget.controller.text.contains(RegExp(r'[A-Z]'));
    if (!lessThan8.value &&
        hasNumber.value &&
        hasSpecialChar.value &&
        hasUppercase.value) {
      widget.showHelper = false;
    } else {
      widget.showHelper = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: (newValue) => widget.controller.text = newValue!,
      cursorHeight: 25.h,
      cursorWidth: 2.w,
      cursorRadius: Radius.circular(10.w),
      onFieldSubmitted: (value) {
        setState(() {
          widget.showHelper = false;
        });
      },
      onChanged: (value) {
        setState(() {
          widget.showHelper = true;
          _validatePassword();
        });
      },
      enableSuggestions: widget.autoSuggest,
      autocorrect: false,
      cursorColor: kPrimaryColor,
      validator: widget.validator,
      controller: widget.controller,
      obscureText: widget.isPassword ? obscureText : false,
      decoration: InputDecoration(
        errorStyle: Styles.textStyle12,
        helper: widget.needHelper && widget.showHelper
            ? Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ValueListenableBuilder<bool>(
                    valueListenable: lessThan8,
                    builder: (context, value, child) {
                      return Row(
                        children: [
                          Icon(Icons.check_circle,
                              color: value ? Colors.grey : kPrimaryColor),
                          SizedBox(width: 5.w),
                          Text('Password must be at least 9 characters',
                              style: Styles.textStyle12),
                        ],
                      );
                    },
                  ),
                  ValueListenableBuilder<bool>(
                    valueListenable: hasNumber,
                    builder: (context, value, child) {
                      return Row(
                        children: [
                          Icon(Icons.check_circle,
                              color: value ? kPrimaryColor : Colors.grey),
                          SizedBox(width: 5.w),
                          Text('Password must contain a number',
                              style: Styles.textStyle12),
                        ],
                      );
                    },
                  ),
                  ValueListenableBuilder<bool>(
                    valueListenable: hasSpecialChar,
                    builder: (context, value, child) {
                      return Row(
                        children: [
                          Icon(Icons.check_circle,
                              color: value ? kPrimaryColor : Colors.grey),
                          SizedBox(width: 5.w),
                          Text('Password must contain a special character',
                              style: Styles.textStyle12),
                        ],
                      );
                    },
                  ),
                  ValueListenableBuilder<bool>(
                    valueListenable: hasUppercase,
                    builder: (context, value, child) {
                      return Row(
                        children: [
                          Icon(Icons.check_circle,
                              color: value ? kPrimaryColor : Colors.grey),
                          SizedBox(width: 5.w),
                          Text('Password must contain an uppercase letter',
                              style: Styles.textStyle12),
                        ],
                      );
                    },
                  ),
                ],
              )
            : null,
        helperStyle: Styles.textStyle12,
        errorMaxLines: 2,
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
