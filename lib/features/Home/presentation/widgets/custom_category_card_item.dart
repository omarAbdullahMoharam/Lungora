import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lungora/core/constants.dart';
import 'package:lungora/core/utils/styles.dart';
import 'package:lungora/features/Home/data/models/category_model.dart';

class CustomCategoryCardItem extends StatelessWidget {
  const CustomCategoryCardItem({
    super.key,
    required this.divider,
    required this.categoryDetails,
    required this.onPressed,
  });
  final CategoryModel categoryDetails;
  final double divider;
  final VoidCallback onPressed;
  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      height: 120.h,
      width: (MediaQuery.of(context).size.width * divider),
      decoration: BoxDecoration(
        color: kPrimaryColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(15.w),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              categoryDetails.vectorImagePath,
              height: 50.h,
              width: 50.w,
              // ignore: deprecated_member_use
              color: kPrimaryColor,
            ),
            SizedBox(height: 8.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Text(
                categoryDetails.categoryName,
                style: Styles.textStyle12.copyWith(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
