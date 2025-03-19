import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lungora/core/constants.dart';
import 'package:lungora/core/utils/styles.dart';

class FAQSection extends StatefulWidget {
  const FAQSection({super.key});

  @override
  State<FAQSection> createState() => _FAQSectionState();
}

class _FAQSectionState extends State<FAQSection> {
  bool isPatientSelected = true; // الحالة الافتراضية (For Patient)

  final List<Map<String, String>> faqs = [
    {
      "question": "What do we do?",
      "answer":
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."
    },
    {
      "question": "How user can join as a provider?",
      "answer": "Lorem ipsum dummy text..."
    },
    {
      "question": "How user can join as a patient?",
      "answer": "Lorem ipsum dummy text..."
    },
    {
      "question": "How user can join as a patient?",
      "answer": "Lorem ipsum dummy text..."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ======= Title =======
          Text(
            "FAQs",
            style: Styles.textStyle16,
          ),
          SizedBox(height: 10.h),

          // ======= Toggle Buttons =======
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isPatientSelected = true;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        isPatientSelected ? kSecondaryColor : Colors.white,
                    foregroundColor:
                        isPatientSelected ? Colors.white : Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      side: BorderSide(
                        color: kSecondaryColor,
                      ),
                    ),
                  ),
                  child: Text("For Patient"),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    setState(() {
                      isPatientSelected = false;
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor:
                        isPatientSelected ? Colors.black : Colors.white,
                    backgroundColor:
                        isPatientSelected ? Colors.white : kSecondaryColor,
                    side: BorderSide(color: kSecondaryColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: Text("For Provider"),
                ),
              ),
            ],
          ),

          SizedBox(height: 20.h),

          ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: faqs.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(bottom: 10.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(10, 0, 0, 0),
                      blurRadius: 5,
                      spreadRadius: 1,
                      offset: Offset(0, 2),
                    )
                  ],
                ),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                    expansionTileTheme: ExpansionTileThemeData(
                      iconColor: Colors.black,
                      collapsedIconColor: Colors.black,
                    ),
                  ),
                  child: ExpansionTile(
                    tilePadding: EdgeInsets.symmetric(horizontal: 16.w),
                    title: Text(
                      faqs[index]["question"]!,
                      style: Styles.textStyle14,
                    ),
                    children: [
                      Padding(
                        padding: EdgeInsets.all(12.w),
                        child: Text(
                          faqs[index]["answer"]!,
                          style:
                              Styles.textStyle12.copyWith(color: Colors.grey),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
