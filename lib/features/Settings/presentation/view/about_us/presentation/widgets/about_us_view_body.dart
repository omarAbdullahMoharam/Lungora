import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lungora/core/utils/app_router.dart';
import 'package:lungora/core/utils/custom_appbar.dart';
import 'package:lungora/core/utils/styles.dart';

import 'faq_section.dart';
import 'how_it_works.dart';
import 'info_card.dart';
import 'statistics_section.dart';

class AboutUsViewBody extends StatelessWidget {
  const AboutUsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textColor = theme.textTheme.bodyLarge?.color ?? Colors.white;
    var backgroundColor = theme.colorScheme.surface;

    return SingleChildScrollView(
      child: Container(
        color: backgroundColor,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 24.w),
              child: CustomAppBar(
                text: "About Us",
                onPressed: () {
                  GoRouter.of(context).go(AppRouter.kSettingsView);
                },
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 24.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "About Us",
                          style: Styles.textStyle16.copyWith(color: textColor),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          'Lungora is an AI-powered mobile application designed to assist in the early detection of lung conditions such as COVID-19 and pneumonia using chest X-ray analysis. Our mission is to make medical insights more accessible and understandable through cutting-edge technology, informative content, and seamless communication with healthcare professionals.',
                          style: Styles.textStyle12.copyWith(color: textColor),
                        ),
                      ],
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 80.h,
                  backgroundImage: AssetImage("assets/images/about_us.jpg"),
                ),
              ],
            ),
            SizedBox(height: 32.h),
            InfoCardSection(),
            SizedBox(height: 24.h),
            StatisticsSection(),
            SizedBox(height: 20.h),
            HowItWorksSection(),
            SizedBox(height: 20.h),
            FAQSection(),
          ],
        ),
      ),
    );
  }
}
