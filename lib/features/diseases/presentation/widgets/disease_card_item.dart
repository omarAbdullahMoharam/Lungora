import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lungora/core/constants.dart';

import 'package:lungora/core/utils/app_router.dart';
import 'package:lungora/core/utils/styles.dart';

class DiseaseCardItem extends StatelessWidget {
  final String diseaseName;
  final String diseaseDescription;
  final String treatmentDescription;

  const DiseaseCardItem({
    super.key,
    required this.diseaseName,
    required this.diseaseDescription,
    required this.treatmentDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16.h),
      child: Card(
        color: kBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.w),
        ),
        child: ListTile(
          title: Text(
            diseaseName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Styles.textStyle16.copyWith(
              fontFamily: 'poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(diseaseDescription,
              maxLines: 4,
              style: Styles.textStyle14.copyWith(
                fontFamily: 'poppins',
                fontWeight: FontWeight.w400,
              )),
          onTap: () {
            context.push(
              AppRouter.kDiseaseDetailsView,
              extra: {
                'diseaseName': diseaseName,
                'diseaseDescription': diseaseDescription,
                'treatmentDescription': treatmentDescription,
              },
            );
          },
        ),
      ),
    );
  }
}
