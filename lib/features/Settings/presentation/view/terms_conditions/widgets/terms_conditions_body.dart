import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lungora/core/constants.dart';
import 'package:lungora/core/utils/app_router.dart';
import 'package:lungora/core/utils/custom_appbar.dart';
import 'package:lungora/core/utils/styles.dart';

class TermsConditionsBody extends StatelessWidget {
  const TermsConditionsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return RawScrollbar(
      thumbColor: kSecondaryColor,
      thickness: 6,
      radius: Radius.circular(10),
      thumbVisibility: true,
      scrollbarOrientation: ScrollbarOrientation.right,
      interactive: true,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(30.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 26.h),
                child: CustomAppBar(
                  text: 'privacy policy',
                  onPressed: () {
                    GoRouter.of(context).go(AppRouter.kSettingsView);
                  },
                ),
              ),
              Text(
                "At Lungora, we prioritize your privacy and data protection. This policy outlines how we collect, use, and safeguard your personal information when you interact with our mobile application.",
                style: Styles.textStyle12.copyWith(fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 16.h),
              Text(
                "We only process your chest X-ray images for medical analysis purposes. These images are transmitted securely to our AI model through encrypted API calls and are not stored or shared with third parties.",
                style: Styles.textStyle12.copyWith(fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 16.h),
              Text(
                "Your interactions with the chatbot, viewed articles, and any personal preferences remain strictly confidential and are only used to improve your experience. No personal health data is collected without your explicit consent.",
                style: Styles.textStyle12.copyWith(fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 16.h),
              Text(
                "By using Lungora, you agree to our terms of use and privacy practices. We reserve the right to update this policy as the platform evolves. For any concerns or inquiries, please contact our support team through the app.",
                style: Styles.textStyle12.copyWith(fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
