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
  bool isPatientSelected = true;

  final List<Map<String, String>> faqsForPatient = [
    {
      "question": "What does Lungora do?",
      "answer":
          "Lungora helps you analyze chest X-ray images using AI to detect potential lung conditions such as COVID-19 or pneumonia.",
    },
    {
      "question": "Is my data safe?",
      "answer":
          "Yes. Your X-ray image is only used for diagnosis and is not stored or shared with anyone.",
    },
    {
      "question": "Can I contact a doctor through the app?",
      "answer":
          "Yes. You can browse a list of available doctors, view their profiles, and get in touch directly.",
    },
    {
      "question": "What if I don’t understand the diagnosis?",
      "answer":
          "You can read related medical articles inside the app or chat with our AI assistant for help.",
    },
  ];

  final List<Map<String, String>> faqsForProvider = [
    {
      "question": "How can I join as a healthcare provider?",
      "answer":
          "You can apply through our dashboard. Once approved by the admin, your profile will appear in the app.",
    },
    {
      "question": "Can I view analytics about my consultations?",
      "answer":
          "Yes, the admin dashboard provides insights into user interactions, model predictions, and overall engagement with your profile.",
    },
    {
      "question": "Will I receive notifications about patient queries?",
      "answer":
          "This feature is currently under development. In future updates, providers will receive notifications when patients attempt to contact or consult with them.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final currentFaqs = isPatientSelected ? faqsForPatient : faqsForProvider;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("FAQs", style: Styles.textStyle16),
          SizedBox(height: 10.h),

          // Toggle Buttons
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
                      side: BorderSide(color: kSecondaryColor),
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

          // FAQs List
          ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: currentFaqs.length,
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
                      currentFaqs[index]["question"]!,
                      style: Styles.textStyle14,
                    ),
                    children: [
                      Padding(
                        padding: EdgeInsets.all(12.w),
                        child: Text(
                          currentFaqs[index]["answer"]!,
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
