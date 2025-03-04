import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lungora/features/Home/data/models/category_model.dart';
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
                categoryDetails: CategoryModel(
                  vectorImagePath: 'assets/icon/Lungs_Outline_Icon.svg',
                  categoryName: 'Chest & Lungs',
                ),
                onPressed: () {},
              ),
            ),
            SizedBox(width: 8.w),
            CustomCategoryCardItem(
              divider: 1.04 / 3,
              categoryDetails: CategoryModel(
                vectorImagePath: 'assets/icon/Heart.svg',
                categoryName: 'Cardiovascular Diseases',
              ),
              onPressed: () {},
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            CustomCategoryCardItem(
              divider: 1 / 3,
              categoryDetails: CategoryModel(
                vectorImagePath: 'assets/icon/X_Ray.svg',
                categoryName: 'Bones & \nMuscles',
              ),
              onPressed: () {},
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: CustomCategoryCardItem(
                divider: 2 / 3,
                categoryDetails: CategoryModel(
                  vectorImagePath: 'assets/icon/Virous.svg',
                  categoryName: 'Gastrointestinal Diseases',
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ],
    );
  }
}
