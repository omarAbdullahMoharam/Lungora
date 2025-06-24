import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:lungora/core/utils/styles.dart';

class EmptyCategories extends StatelessWidget {
  const EmptyCategories({
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
          'assets/animation/empty_categories.json',
          width: 200.w,
          height: 200.h,
          fit: BoxFit.cover,
        ),
        SizedBox(height: 16),
        Text(
          "No articles found.",
          style: Styles.textStyle16.copyWith(
            fontWeight: FontWeight.w500,
            color: Colors.black54,
          ),
        ),
      ],
    ));
  }
}
