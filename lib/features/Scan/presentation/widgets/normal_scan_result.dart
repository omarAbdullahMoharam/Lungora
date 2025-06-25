import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lungora/core/utils/app_router.dart';
import 'package:lungora/core/utils/styles.dart';
import 'package:go_router/go_router.dart';
import 'scan_result_image.dart';

class NormalScanResult extends StatelessWidget {
  final File? imageFile;
  const NormalScanResult({super.key, required this.imageFile});
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
      body: Stack(children: [
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
                    "Normal Results",
                    style: Styles.textStyle24.copyWith(
                      color: Colors.green,
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                Text(
                  "\"Great News!\"",
                  style: Styles.textStyle20,
                ),
                SizedBox(height: 8.h),
                Text(
                  "Your test results are clear!",
                  style: Styles.textStyle14,
                ),
                Text(
                  "You're in good health. Continue practicing preventive measures to stay safe and healthy.",
                  style: Styles.textStyle12,
                ),
                SizedBox(height: 24.h),
                Text(
                  "Recommended Actions:",
                  style: Styles.textStyle16,
                ),
                SizedBox(height: 8.h),
                Text(
                  "1. Maintain a healthy diet.\n"
                  "2. Stay active with regular exercise.\n"
                  "3. Follow good hygiene practices.\n"
                  "4. Keep monitoring your health regularly.",
                  style: Styles.textStyle12,
                ),
              ],
            ),
          ),
        ),
        // Positioned(
        //   bottom: 10.h,
        //   right: 32.w,
        //   child: FlotingActionButton(),
        // ),
      ]),
    );
  }
}
