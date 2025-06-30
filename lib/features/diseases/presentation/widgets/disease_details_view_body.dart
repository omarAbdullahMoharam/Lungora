import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lungora/core/constants.dart';
import 'package:lungora/core/utils/styles.dart';
import 'package:lungora/features/diseases/presentation/widgets/custom_chat_and_doctor_buttons.dart';
import 'disease_stats_section.dart';

// ignore: must_be_immutable
class DiseaseDetailsViewBody extends StatelessWidget {
  final String diseaseName;
  final String diseaseDescription;
  final String treatmentMethods;
  String? diseaseImageUrl;
  DiseaseDetailsViewBody({
    super.key,
    required this.diseaseName,
    required this.treatmentMethods,
    required this.diseaseDescription,
    this.diseaseImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 24.w,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16.w),
              child: diseaseImageUrl != null
                  ? CachedNetworkImage(
                      placeholder: (context, url) => Container(
                        height: 160.h,
                        width: double.infinity,
                        color: Colors.grey.shade200,
                      ),
                      errorWidget: (context, url, error) => Container(
                        height: 160.h,
                        width: double.infinity,
                        color: Colors.grey.shade200,
                        child: const Icon(Icons.error),
                      ),
                      imageUrl: diseaseImageUrl!,
                      height: 160.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
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
                fontWeight: FontWeight.w900,
                color: kPrimaryColor,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              diseaseDescription,
              style: Styles.textStyleInter16.copyWith(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              'Treatment methods',
              style: Styles.textStyleInter16.copyWith(
                color: kPrimaryColor,
                fontWeight: FontWeight.w900,
              ),
            ),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: treatmentMethods.replaceAll(r'\n', '\n'),
                    style: Styles.textStyleInter16.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            ChatAndDoctorButtons(),
          ],
        ),
      ),
    );
  }
}
