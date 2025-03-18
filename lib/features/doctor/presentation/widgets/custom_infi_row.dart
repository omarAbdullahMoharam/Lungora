import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lungora/core/utils/styles.dart';

class CustomInfiRow extends StatelessWidget {
  final String iconPath;
  final String text;

  const CustomInfiRow({
    super.key,
    required this.iconPath,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SvgPicture.asset(
          iconPath,
          width: 20.w,
          height: 20.h,
        ),
        SizedBox(width: 8.w),
        Text(
          text,
          style: Styles.textStyle14,
        ),
      ],
    );
  }
}
