import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lungora/core/constants.dart';
import 'package:lungora/core/utils/styles.dart';

class DoctorStatsCard extends StatelessWidget {
  final String patients;
  final String experiences;

  const DoctorStatsCard({
    super.key,
    required this.patients,
    required this.experiences,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50.w),
          topRight: Radius.circular(50.w),
        ),
      ),
      padding: EdgeInsets.only(
        top: 18.h,
        left: 32.w,
        right: 32.w,
        bottom: 58.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            backgroundColor: Colors.blue.withValues(alpha: 0.3),
            radius: 28.h,
            child: SvgPicture.asset(
              'assets/icon/people.svg',
              width: 20.w,
              height: 20.h,
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  patients,
                  style: Styles.textStyle20.copyWith(
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Patients',
                  style: Styles.textStyle14.copyWith(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          CircleAvatar(
            backgroundColor: Colors.blue.withAlpha((0.3 * 255).round()),
            radius: 28.h,
            child: SvgPicture.asset(
              'assets/icon/eperince.svg',
              width: 20.w,
              height: 20.h,
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  experiences,
                  style: Styles.textStyle20.copyWith(
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Experiences',
                  style: Styles.textStyle14.copyWith(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
