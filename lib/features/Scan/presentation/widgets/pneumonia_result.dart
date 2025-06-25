import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lungora/core/constants.dart';
import 'package:lungora/core/utils/app_router.dart';
import 'package:lungora/core/utils/styles.dart';
import 'package:go_router/go_router.dart';
import 'package:lungora/features/Scan/presentation/widgets/scan_result_image.dart';
import 'package:lungora/features/diseases/presentation/widgets/disease_stats_section.dart';

class PneumoniaResult extends StatelessWidget {
  final File? imageFile;
  const PneumoniaResult({super.key, required this.imageFile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_outlined, size: 35.sp),
          onPressed: () {
            context.go(AppRouter.kScanView);
          },
        ),
        backgroundColor: Colors.white,
        title: const Text(""),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScanResultImage(
              imageFile: imageFile,
              onPressed: () {
                context.go(AppRouter.kScanView);
              },
            ),
            SizedBox(height: 16.h),
            Center(
              child: Text(
                "(Pneumonia)",
                style: Styles.textStyle24.copyWith(color: kPrimaryColor),
              ),
            ),
            SizedBox(height: 16.h),
            DiseaseStatsSection(),
            SizedBox(height: 16.h),
            Text("Symptoms", style: Styles.textStyle16),
            SizedBox(height: 8.h),
            Text(
              "Cough with phlegm or pus, chest pain when breathing or coughing, fever, chills, difficulty breathing, fatigue, nausea or vomiting, and confusion (especially in older adults).",
              style: Styles.textStyle12,
            ),
            SizedBox(height: 16.h),
            Text("Diagnose", style: Styles.textStyle16),
            SizedBox(height: 8.h),
            Text(
              "Diagnosis is typically based on physical examination and confirmed with chest X-rays, blood tests, or sputum analysis.",
              style: Styles.textStyle12,
            ),
            SizedBox(height: 16.h),
            Text("Treatment Disease", style: Styles.textStyle16),
            SizedBox(height: 8.h),
            _buildRichTextSection(
              "1. Antibiotics:",
              [
                "Amoxicillin: Common first-line antibiotic for bacterial pneumonia.",
                "Azithromycin: Used in patients with penicillin allergy or atypical bacteria.",
              ],
            ),
            _buildRichTextSection(
              "2. Fever and Pain Relievers:",
              [
                "Paracetamol (Acetaminophen): Reduces fever and relieves mild pain.",
                "Ibuprofen: Relieves fever, muscle pain, and inflammation.",
              ],
            ),
            _buildRichTextSection(
              "3. Cough Medications:",
              [
                "Cough Suppressants: To reduce persistent dry cough.",
                "Expectorants: Help clear mucus from the lungs.",
              ],
            ),
            _buildRichTextSection(
              "4. Supportive Care:",
              [
                "Plenty of rest: Helps the body recover.",
                "Hydration: Drink fluids to loosen mucus.",
                "Humidifiers: Moisturize air and ease breathing.",
              ],
            ),
            _buildRichTextSection(
              "5. Hospitalization (Severe Cases):",
              [
                "Oxygen therapy: If blood oxygen levels are low.",
                "IV antibiotics and fluids: In serious cases or for high-risk patients.",
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRichTextSection(String title, List<String> items) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Styles.textStyle14.copyWith(
              fontWeight: FontWeight.bold,
              color: kPrimaryColor,
            ),
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
}
