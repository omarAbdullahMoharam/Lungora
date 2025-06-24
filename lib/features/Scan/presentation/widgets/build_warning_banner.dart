import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lungora/core/constants.dart';
import 'package:lungora/core/utils/styles.dart';

Widget buildWarningBanner(
    {File? selectedImage, required BuildContext context}) {
  if (selectedImage != null) return const SizedBox.shrink();

  return Container(
    height: 70.h,
    decoration: BoxDecoration(
      color: kSecondaryColor.withOpacity(0.1),
      borderRadius: BorderRadius.circular(16.w),
    ),
    child: DottedBorder(
      options: RoundedRectDottedBorderOptions(
        strokeWidth: 2.w,
        dashPattern: [8, 4],
        color: Colors.amber.shade400,
        radius: Radius.circular(16.w),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: FaIcon(
            FontAwesomeIcons.triangleExclamation,
            color: Colors.amber.shade600,
            size: 30.w,
          ),
          title: Text(
            "Upload a clear X-ray image without blur or background less than 10 MB.",
            style: Styles.textStyleInter16.copyWith(
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    ),
  );
}
