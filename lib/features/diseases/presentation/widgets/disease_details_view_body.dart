import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lungora/core/constants.dart';
import 'package:lungora/core/utils/app_roture.dart';
import 'package:lungora/core/utils/styles.dart';

import 'disease_stats_section.dart';

class DiseaseDetailsViewBody extends StatelessWidget {
  final String diseaseName;
  final String diseaseDescription;
  final String treatmentMethods;
  const DiseaseDetailsViewBody({
    super.key,
    required this.diseaseName,
    required this.treatmentMethods,
    required this.diseaseDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 24.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16.w),
            child: Image.asset(
              'assets/images/lung_desease.png',
              height: 160.h,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 16.h),
          Center(
            child: Text(
              diseaseName,
              style: Styles.textStyle24.copyWith(
                fontFamily: 'Inter',
              ),
            ),
          ),
          const SizedBox(height: 16),
          DiseaseStatsSection(),
          SizedBox(height: 24.h),
          Text(
            'Description',
            textAlign: TextAlign.start,
            style: Styles.textStyleInter16.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            diseaseDescription,
            style: Styles.textStyle12.copyWith(
              fontFamily: 'Inter',
            ),
          ),
          SizedBox(height: 24.h),

          Text(
            'Treatment methods',
            style: Styles.textStyleInter16.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: treatmentMethods.replaceAll(r'\n', '\n'),
                  style: Styles.textStyle12.copyWith(
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
          ),

          // Text(
          //   'Treatment methods',
          //   textAlign: TextAlign.start,
          //   style: Styles.textStyleInter16.copyWith(
          //     fontWeight: FontWeight.w700,
          //   ),
          // ),
          // Text(
          //   treatmentMethods,
          //   style: Styles.textStyle12.copyWith(
          //     fontFamily: 'Inter',
          //   ),
          // ),

          const Spacer(),
          Padding(
            padding: EdgeInsets.only(bottom: 16.h),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    context.push(AppRoture.kDoctorView);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.h),
                    ),
                  ),
                  child: const Text("Discuss a doctor"),
                ),
                OutlinedButton(
                  onPressed: () {
                    context.push(AppRoture.kChatView);
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: kPrimaryColor,
                    side: const BorderSide(color: kPrimaryColor, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.h),
                    ),
                  ),
                  child: const Text("Chatbot"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
