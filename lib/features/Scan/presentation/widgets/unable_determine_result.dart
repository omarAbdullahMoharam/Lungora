import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lungora/core/utils/app_router.dart';

import 'package:lungora/core/utils/styles.dart';

import 'floting_action_button.dart';
import 'scan_result_image.dart';

class UnableDetermineResult extends StatelessWidget {
  const UnableDetermineResult({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ScanResultImage(
                    imageUrl: 'assets/images/scan_result.png',
                    onPressed: () {
                      context.go(AppRouter.kCovid19Result);
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
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 10.h,
            right: 32.w,
            child: FlotingActionButton(),
          ),
        ]),
      ),
    );
  }
}
