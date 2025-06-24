import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:lungora/core/constants.dart';

Widget buildProcessingImage({File? selectedImage}) {
  return Stack(
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.file(
          selectedImage!,
          height: 290.h,
          width: 250.w,
          fit: BoxFit.cover,
        ),
      ),
      Positioned.fill(
        child: Container(
          decoration: BoxDecoration(
            color: kSecondaryColor.withOpacity(0.5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: LottieBuilder.asset(
              'assets/animation/Animation-Proccessing.json',
              height: 100.h,
              width: 100.w,
            ),
          ),
        ),
      ),
    ],
  );
}
