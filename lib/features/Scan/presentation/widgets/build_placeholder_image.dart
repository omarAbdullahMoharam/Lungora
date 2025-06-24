import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildPlaceholderImage() {
  return Container(
    height: 290.h,
    width: 250.w,
    decoration: BoxDecoration(
      color: Colors.grey[300],
      borderRadius: BorderRadius.circular(12),
    ),
    child: Image.asset(
      'assets/images/lung_scan.png',
      height: 290.h,
      width: 230.w,
      fit: BoxFit.fill,
    ),
  );
}
