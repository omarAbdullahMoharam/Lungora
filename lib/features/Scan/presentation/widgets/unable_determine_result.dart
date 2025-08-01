import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lungora/core/utils/app_router.dart';

import 'package:lungora/core/utils/styles.dart';
import 'package:lungora/features/diseases/presentation/widgets/custom_chat_and_doctor_buttons.dart';

import 'scan_result_image.dart';

class UnableDetermineResult extends StatelessWidget {
  final File? imageFile;
  const UnableDetermineResult({super.key, required this.imageFile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            size: 35.sp,
          ),
          onPressed: () {
            context.go(AppRouter.kScanView);
          },
        ),
        title: Text(""),
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ScanResultImage(
                    imageFile: imageFile,
                    onPressed: () {
                      context.go(AppRouter.kScanView);
                    },
                  ),
                  SizedBox(height: 16.h),
                  Center(
                    child: Text(
                      "Unable to Determine Results",
                      style: Styles.textStyle24.copyWith(
                        color: Color(0xFFB81013),
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    "OPPS !!",
                    style: Styles.textStyle20,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "We couldn't interpret your test results at this time. This may happen due to incomplete data or an unexpected issue.",
                    style: Styles.textStyle14,
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    "Next Steps:",
                    style: Styles.textStyle16,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "1. Ensure your test was conducted properly.\n"
                    "2. Try submitting the data again.\n"
                    "3. Contact support or your healthcare provider for assistance.",
                    style: Styles.textStyle12,
                  ),
                  SizedBox(height: 24.h),
                  ChatAndDoctorButtons(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
