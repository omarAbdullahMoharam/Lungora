import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lungora/core/constants.dart';
import 'package:lungora/core/utils/app_router.dart';
import 'package:lungora/core/utils/custom_appbar.dart';
import 'package:lungora/core/utils/styles.dart';

class PrivacyViewBody extends StatelessWidget {
  const PrivacyViewBody({super.key});

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
                "At Lungora, your privacy is our top priority. This privacy policy outlines how we handle and protect the data you provide while using our mobile application.",
                style: Styles.textStyle12.copyWith(fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 16.h),
              Text(
                "We only collect data necessary to deliver our services, including chest X-ray images for diagnostic purposes. These images are transmitted securely to our AI model via API and are not stored on our servers.",
                style: Styles.textStyle12.copyWith(fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 16.h),
              Text(
                "We do not sell, share, or distribute any personal data to third parties. Any interaction with the chatbot, articles, or doctors remains confidential and encrypted.",
                style: Styles.textStyle12.copyWith(fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 16.h),
              Text(
                "By continuing to use Lungora, you consent to our privacy practices. This policy may be updated periodically. For more information, please refer to our Terms and Conditions or contact support.",
                style: Styles.textStyle12.copyWith(fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
