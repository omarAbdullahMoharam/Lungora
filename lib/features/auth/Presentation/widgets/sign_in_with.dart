import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSignInWith extends StatelessWidget {
  const CustomSignInWith({
    super.key,
    required this.signInWith,
    required this.imagePath,
  });
  final VoidCallback signInWith;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: signInWith,
      child: Container(
        width: 49.5.w,
        height: 50.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.w),
        ),
        child: Image.asset(
          imagePath,
        ),
      ),
    );
  }
}
