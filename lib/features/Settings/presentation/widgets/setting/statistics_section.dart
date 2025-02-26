import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lungora/core/utils/styles.dart';

class StatisticsSection extends StatelessWidget {
  StatisticsSection({super.key});

  final List<Map<String, String>> stats = [
    {"value": "+950", "label": "Satisfied Clients"},
    {"value": "+50", "label": "Providers"},
    {"value": "12", "label": "Years Experience"},
    {"value": "+150", "label": "Services"},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Our Numbers",
            style: Styles.textStyle16.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12.h),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.5.h,
              crossAxisSpacing: 12.w,
              mainAxisSpacing: 12.h,
            ),
            itemCount: stats.length,
            itemBuilder: (context, index) {
              return _statItem(stats[index]["value"]!, stats[index]["label"]!);
            },
          ),
        ],
      ),
    );
  }

  Widget _statItem(String value, String label) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
      decoration: BoxDecoration(
        color: Color(0xFFECF4F9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: Styles.textStyle16,
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: Styles.textStyle12.copyWith(fontFamily: 'Inter'),
          ),
        ],
      ),
    );
  }
}
