import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildSelectedImage({File? selectedImage}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(12),
    child: Image.file(
      selectedImage!,
      height: 290.h,
      width: 250.w,
      fit: BoxFit.cover,
    ),
  );
}
