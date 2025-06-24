import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lungora/core/constants.dart';

class EditableImagePreview extends StatelessWidget {
  final File? selectedImage;
  final VoidCallback? onEditTap;

  const EditableImagePreview({
    super.key,
    required this.selectedImage,
    required this.onEditTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: selectedImage != null
              ? Image.file(
                  selectedImage!,
                  height: 290.h,
                  width: 250.w,
                  fit: BoxFit.cover,
                )
              : Container(
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
                ),
        ),
        Positioned.fill(
          child: GestureDetector(
            onTap: selectedImage == null ? null : onEditTap,
            child: DottedBorder(
              options: RoundedRectDottedBorderOptions(
                radius: Radius.circular(12.w),
                strokeWidth: 2.w,
                dashPattern: [8, 4],
                color: kPrimaryColor,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: kSecondaryColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: selectedImage == null
                      ? const SizedBox.shrink()
                      : SvgPicture.asset(
                          'assets/icon/crop.svg',
                          height: 50.h,
                          width: 50.w,
                          color: kPrimaryColor,
                        ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
