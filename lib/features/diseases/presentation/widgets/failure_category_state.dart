import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:lungora/core/utils/styles.dart';

class FailedCategories extends StatelessWidget {
  const FailedCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(
            'assets/animation/categories_failed.json',
            width: 200.w,
            height: 200.h,
            fit: BoxFit.cover,
          ),
          Text(
            "Failed to load categories.",
            style: Styles.textStyle16.copyWith(
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
