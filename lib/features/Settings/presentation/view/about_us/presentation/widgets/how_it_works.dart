import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lungora/core/constants.dart';
import 'package:lungora/core/utils/styles.dart';

class HowItWorksSection extends StatelessWidget {
  HowItWorksSection({super.key});

  final List<Map<String, String>> steps = [
    {
      "step": "1",
      "title": "Patient search for service",
      "subtitle":
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum",
    },
    {
      "step": "2",
      "title": "Compare providers",
      "subtitle":
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum",
    },
    {
      "step": "3",
      "title": "Reserve an appointment",
      "subtitle":
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("How It Works", style: Styles.textStyle16),
          SizedBox(height: 12.h),
          ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: steps.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  radius: 15,
                  backgroundColor: Color(0xFFECF4F9),
                  child: Text(
                    steps[index]["step"]!,
                    style: TextStyle(color: kSecondaryColor),
                  ),
                ),
                title: Text(steps[index]["title"]!, style: Styles.textStyle14),
                subtitle: Text(
                  steps[index]["subtitle"]!,
                  style: Styles.textStyle12,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
