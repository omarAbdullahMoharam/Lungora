import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lungora/core/constants.dart';
import 'package:lungora/core/utils/app_router.dart';
import 'package:lungora/core/utils/styles.dart';
import 'package:go_router/go_router.dart';

import 'package:lungora/features/diseases/presentation/widgets/disease_stats_section.dart';
import 'floting_action_button.dart';
import 'scan_result_image.dart';

class Covid19Result extends StatelessWidget {
  const Covid19Result({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            size: 35.sp,
          ),
          onPressed: () {
            context.go(AppRouter.kScanView);
          },
        ),
        // backgroundColor: kSecondaryColor,
        title: Text(""),
        backgroundColor: Colors.white,
        // centerTitle: true,
      ),
      body: Stack(children: [
        SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ScanResultImage(
                  imageUrl: 'assets/images/scan_result.png',
                  onPressed: () {
                    context.go(AppRouter.kScanView);
                  },
                ),
                SizedBox(height: 16.h),
                Center(
                  child: Text(
                    "(COVID-19)",
                    style: Styles.textStyle24.copyWith(
                      color: kPrimaryColor,
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                DiseaseStatsSection(),
                SizedBox(height: 16.h),
                Text(
                  "Symptoms",
                  style: Styles.textStyle16,
                ),
                SizedBox(height: 8.h),
                Text(
                  "Fever or chills , Cough , Shortness of breath or difficulty breathing , Fatigue , Muscle or , body aches , Headache , New loss of taste or smell , Sore throat , Congestion or runny nose , Nausea or vomiting , Diarrhea .",
                  style: Styles.textStyle12,
                ),
                SizedBox(height: 16.h),
                Text(
                  " Diagnose",
                  style: Styles.textStyle16,
                ),
                SizedBox(height: 8.h),
                Text(
                  "Lorem Ipsum is simply dummy text of the printing ",
                  style: Styles.textStyle12,
                ),
                SizedBox(height: 16.h),
                Text(
                  "Treatment Disease",
                  style: Styles.textStyle16,
                ),
                SizedBox(height: 8.h),
                _buildRichTextSection(
                  "1. Pain and Fever Relievers:",
                  [
                    "Paracetamol (Acetaminophen): Used to reduce fever and relieve pain.",
                    "Ibuprofen: Helps reduce pain, inflammation, and fever.",
                  ],
                ),
                _buildRichTextSection(
                  "2. Decongestants:",
                  [
                    "Oral Decongestants: Such as Sudafed (Pseudoephedrine), help relieve nasal congestion.",
                    "Nasal Sprays: Such as Oxymetazoline, help open nasal passages.",
                  ],
                ),
                _buildRichTextSection(
                  "3. Cough Medications:",
                  [
                    "Cough Suppressants: Like Dextromethorphan, which helps reduce dry cough.",
                    "Expectorants: Like Guaifenesin, which loosens mucus and makes coughing easier.",
                  ],
                ),
                _buildRichTextSection(
                  "4. Antihistamines:",
                  [
                    "Chlorpheniramine or Diphenhydramine: Help relieve symptoms like a runny nose, sneezing, and itchy eyes.",
                  ],
                ),
                _buildRichTextSection(
                  "5. Home Remedies:",
                  [
                    "Rest: Getting plenty of rest helps strengthen the immune system.",
                    "Fluids: Drinking fluids like water, tea, and soups helps stay hydrated and relieves symptoms.",
                    "Steam Inhalation: Can help reduce nasal congestion.",
                    "Honey: Can soothe the throat and reduce coughing.",
                  ],
                ),
                _buildRichTextSection(
                  "6. Stress Reduction:",
                  [
                    "Managing stress is important for overall recovery as it can impact immune function.",
                  ],
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: FlotingActionButton(),
          ),
        ),
      ]),
    );
  }
}

Widget _buildRichTextSection(String title, List<String> items) {
  return Padding(
    padding: EdgeInsets.only(bottom: 16.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Styles.textStyle14
              .copyWith(fontWeight: FontWeight.bold, color: kPrimaryColor),
        ),
        SizedBox(height: 8.h),
        ...items.map((item) => Padding(
              padding: EdgeInsets.only(left: 8.w, bottom: 4.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("• ",
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.bold)),
                  Expanded(child: Text(item, style: Styles.textStyle12)),
                ],
              ),
            )),
      ],
    ),
  );
}
