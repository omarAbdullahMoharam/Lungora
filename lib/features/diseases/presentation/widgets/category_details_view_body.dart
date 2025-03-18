import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lungora/core/utils/styles.dart';
import 'package:lungora/features/diseases/presentation/widgets/disease_data.dart';
import 'disease_card_item.dart';

class CategoryDetailsViewBody extends StatelessWidget {
  final String categoryName;
  const CategoryDetailsViewBody({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    final diseasesList = DiseaseData.diseases[categoryName]!;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            categoryName,
            style: Styles.textStyle16.copyWith(
              fontWeight: FontWeight.w800,
              fontFamily: 'poppins',
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: diseasesList.length,
              itemBuilder: (context, index) {
                final disease = diseasesList[index];

                return DiseaseCardItem(
                  diseaseName: disease['name']!,
                  diseaseDescription: disease['description']!,
                  treatmentDescription: disease['treatment']!,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
