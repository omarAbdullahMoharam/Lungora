import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lungora/core/constants.dart';
import 'package:lungora/core/utils/styles.dart';

class InfoCardSection extends StatelessWidget {
  InfoCardSection({super.key});

  final List<Map<String, dynamic>> features = [
    {
      "icon": Icons.star_outline,
      "title": "Expertise",
      "description":
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
    },
    {
      "icon": Icons.forum_outlined,
      "title": "Communication",
      "description":
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
    },
    {
      "icon": Icons.support_agent,
      "title": "24/7 Support",
      "description":
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "About Fishy",
            style: Styles.textStyle16,
          ),
          const SizedBox(height: 10),
          Column(
            children: features.map((feature) => _infoCard(feature)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _infoCard(Map<String, dynamic> feature) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100], // لون خلفية فاتح
        borderRadius: BorderRadius.circular(12.h),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(feature["icon"], color: kSecondaryColor, size: 40),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  feature["title"],
                  style: Styles.textStyle14,
                ),
                SizedBox(height: 8.h),
                Text(
                  feature["description"],
                  style: Styles.textStyle12,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
