import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:lungora/core/utils/styles.dart';

class LoadingMessageIndicator extends StatelessWidget {
  const LoadingMessageIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          color: const Color(0xFFEDF2F7),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
              "assets/images/animatedRobot.json",
              width: 50,
              height: 50,
            ),
            SizedBox(width: 8.w),
            Text(
              'Loading...',
              style: Styles.textStyle12,
            ),
          ],
        ),
      ),
    );
  }
}
