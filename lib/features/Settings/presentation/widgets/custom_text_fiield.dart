import 'package:flutter/material.dart';
import 'package:lungora/core/constants.dart';

class CustomTextField extends StatelessWidget {
  final IconData? icon;
  final String hint;
  final int maxLines;

  const CustomTextField({
    super.key,
    this.icon,
    required this.hint,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      decoration: InputDecoration(
        prefixIcon: icon != null ? Icon(icon, color: kSecondaryColor) : null,
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: kSecondaryColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: kSecondaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: kSecondaryColor),
        ),
      ),
    );
  }
}
