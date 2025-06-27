import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lungora/core/utils/styles.dart';

import 'package:go_router/go_router.dart';
import 'package:lungora/core/utils/app_router.dart';
import 'package:lungora/features/Home/presentation/widgets/profile_image_button.dart';

AppBar buildCustomAppBar({
  required BuildContext context,
  String? title,
  VoidCallback? onProfilePressed,
  bool showProfileImage = true,
}) {
  return AppBar(
    automaticallyImplyLeading: false,
    title: Padding(
      padding: EdgeInsets.only(left: 16.w),
      child: Text(
        title ?? 'Lungora',
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
      if (showProfileImage) ...[
        ProfileImageButton(
          onPressed:
              onProfilePressed ?? () => context.go(AppRouter.kSettingsView),
        ),
        SizedBox(width: 16.w),
      ],
    ],
  );
}

// نسخة مبسطة للـ AppBar بدون dependencies إضافية
AppBar buildSimpleCustomAppBar({
  required BuildContext context,
  required String imagePath,
  required VoidCallback onPressed,
  String? title,
}) {
  return AppBar(
    automaticallyImplyLeading: false,
    title: Padding(
      padding: EdgeInsets.only(left: 16.w),
      child: Text(
        title ?? 'Lungora',
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
        icon: SizedBox(
          height: 42.h,
          width: 42.w,
          child: ClipRRect(
            clipBehavior: Clip.antiAlias,
            borderRadius: BorderRadius.circular(60.r),
            child: Image(
              image: imagePath.startsWith('http')
                  ? NetworkImage(imagePath)
                  : FileImage(File(imagePath)) as ImageProvider,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.person, color: Colors.grey);
              },
            ),
          ),
        ),
      ),
      SizedBox(width: 16.w),
    ],
  );
}
