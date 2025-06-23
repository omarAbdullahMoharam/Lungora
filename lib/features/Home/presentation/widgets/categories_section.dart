import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lungora/core/utils/app_router.dart';
import 'package:lungora/features/Home/data/models/category_card_model.dart';
import 'package:lungora/features/Home/presentation/widgets/custom_category_card_item.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: CustomCategoryCardItem(
                divider: 2 / 3,
                categoryDetails: CategoryCardModel(
                  vectorImagePath: 'assets/icon/Lungs_Outline_Icon.svg',
                  categoryName: 'Chest & Lungs',
                ),
                onPressed: () {
                  context.push(
                    AppRouter.kCategoriesView,
                    extra: 'Chest & Lungs',
                    // extra: {
                    // 'diseaseName': 'Chest & Lungs',
                    // 'diseaseDescription':
                    //     'Information about respiratory conditions including pneumonia, asthma, and COPD',
                    // 'treatmentDescription':
                    //     'Treatments include inhalers, antibiotics, oxygen therapy, and pulmonary rehabilitation',

                    //   'categoryName': 'Chest & Lungs',
                    // },
                  );
                },
              ),
            ),
            SizedBox(width: 8.w),
            CustomCategoryCardItem(
              divider: 1.04 / 3,
              categoryDetails: CategoryCardModel(
                vectorImagePath: 'assets/icon/Heart.svg',
                categoryName: 'Cardiovascular Diseases',
              ),
              onPressed: () {
                context.push(
                  AppRouter.kDiseaseDetailsView,
                  extra: 'Cardiovascular Diseases',
                  // extra: {
                  // 'diseaseName': 'Cardiovascular Diseases',
                  // 'diseaseDescription':
                  //     'Information about heart and blood vessel conditions including hypertension and coronary artery disease',
                  // 'treatmentDescription':
                  //     'Treatments include lifestyle changes, medications, and surgical procedures when necessary',
                  //   'categoryName': 'Cardiovascular Diseases'
                  // },
                );
              },
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            CustomCategoryCardItem(
              divider: 1 / 3,
              categoryDetails: CategoryCardModel(
                vectorImagePath: 'assets/icon/X_Ray.svg',
                categoryName: 'Bones & \nMuscles',
              ),
              onPressed: () {
                context.push(
                  AppRouter.kDiseaseDetailsView,
                  extra: 'Bones & Muscles',
                  // extra: {
                  // 'diseaseName': 'Bones & Muscles',
                  // 'diseaseDescription':
                  //     'Information about bone and muscle conditions including fractures, arthritis, and muscle disorders',
                  // 'treatmentDescription':
                  //     'Treatments include physical therapy, medications, surgery, and rehabilitation exercises',
                  //   'categoryName': 'Bones & Muscles',
                  // },
                );
              },
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: CustomCategoryCardItem(
                divider: 2 / 3,
                categoryDetails: CategoryCardModel(
                  vectorImagePath: 'assets/icon/Virous.svg',
                  categoryName: 'Gastrointestinal Diseases',
                ),
                onPressed: () {
                  context.push(
                    AppRouter.kCategoriesView,
                    extra: 'Gastrointestinal Diseases',
                    // extra: {
                    // 'diseaseName': 'Gastrointestinal Diseases',
                    // 'diseaseDescription':
                    //     'Information about digestive system disorders including GERD, IBS, and other gastrointestinal conditions',
                    // 'treatmentDescription':
                    //     'Treatments include dietary changes, medications, lifestyle modifications, and in some cases surgery',
                    //   'categoryName': 'Gastrointestinal Diseases',
                    // },
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
