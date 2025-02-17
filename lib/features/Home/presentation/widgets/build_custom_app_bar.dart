import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lungora/core/utils/styles.dart';

AppBar buildCustomAppBar({
  required BuildContext context,
  required String imagePath,
  required VoidCallback onPressed,
}) {
  return AppBar(
    title: Padding(
      padding: EdgeInsets.only(left: 16.w),
      child: Text(
        'Lungora',
        style: Styles.textStyle20.copyWith(
          fontWeight: FontWeight.w700,
          fontFamily: 'Inter',
          height: 22.sp,
        ),
      ),
    ),
    backgroundColor: Colors.transparent,
    elevation: 0,
    actions: [
      IconButton(
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        icon: AspectRatio(
          aspectRatio: 1.spMin,
          child: ClipRRect(
            clipBehavior: Clip.antiAlias,
            borderRadius: BorderRadius.circular(25.r),
            child: Image.asset(
              imagePath,
              width: 32.w,
              height: 32.h,
            ),
          ),
        ),
      ),
      SizedBox(width: 16.w),
    ],
  );
}
