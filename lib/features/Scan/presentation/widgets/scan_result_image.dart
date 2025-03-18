import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScanResultImage extends StatelessWidget {
  final String imageUrl;
  final void Function() onPressed;
  const ScanResultImage({
    super.key,
    required this.imageUrl,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        height: 280.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.h),
          boxShadow: [],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.h),
          child: Image.asset(
            imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
      Positioned(
        top: 24.h,
        left: 12.w,
        child: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 35.sp,
          ),
          onPressed: onPressed,
        ),
      ),
    ]);
  }
}
