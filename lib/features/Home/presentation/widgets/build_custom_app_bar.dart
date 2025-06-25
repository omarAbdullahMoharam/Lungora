import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lungora/core/utils/styles.dart';

AppBar buildCustomAppBar({
  required BuildContext context,
  required String imagePath,
  required VoidCallback onPressed,
  // required bool isProfileLoaded,
}) {
  return AppBar(
    automaticallyImplyLeading: false,
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
    backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
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
            child:
                //  Image.network(imagePath)
                Image(
              image: imagePath.startsWith('http')
                  ? NetworkImage(imagePath)
                  : FileImage(File(imagePath)) as ImageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      SizedBox(width: 16.w),
    ],
  );
}
