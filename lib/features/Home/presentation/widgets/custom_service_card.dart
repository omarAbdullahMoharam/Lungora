import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lungora/core/utils/styles.dart';

class CustomServiceCard extends StatelessWidget {
  const CustomServiceCard({
    super.key,
    required this.imagePath,
    required this.serviceName,
    required this.onTapped,
  });
  final String imagePath;
  final String serviceName;
  final VoidCallback onTapped;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapped,
      child: SizedBox(
        width: 187.w,
        height: MediaQuery.of(context).size.height * 0.171,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              clipBehavior: Clip.antiAlias,
              child: Image.asset(
                imagePath,
                fit: BoxFit.fill,
                height: 114.h,
                width: 187.w,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              serviceName,
              style: Styles.textStyle16.copyWith(
                fontWeight: FontWeight.w600,
                fontFamily: 'Montserrat',
              ),
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}
