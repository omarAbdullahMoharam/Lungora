import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lungora/core/constants.dart';
import 'package:lungora/core/utils/styles.dart';

class DiseaseStatsCard extends StatelessWidget {
  final String title;
  final String value;

  const DiseaseStatsCard({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.black12
            : kBackgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: Styles.textStyle14.copyWith(
              color: kSecondaryColor,
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            value,
            style: Styles.textStyle14.copyWith(
              color: kSecondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
