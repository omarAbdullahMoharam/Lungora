import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:lungora/core/utils/styles.dart';

class LoadingCategories extends StatelessWidget {
  const LoadingCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(
          'assets/animation/Loading_Articles.json',
          width: 200.w,
          height: 200.h,
          fit: BoxFit.cover,
        ),
        SizedBox(height: 16),
        Text(
          "Loading categories and articles...",
          style: Styles.textStyle16.copyWith(
            fontWeight: FontWeight.w500,
            color: Colors.black54,
          ),
        ),
      ],
    ));
  }
}
