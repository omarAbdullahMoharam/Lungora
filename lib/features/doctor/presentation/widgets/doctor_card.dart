import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lungora/core/constants.dart';
import 'package:lungora/core/utils/styles.dart';

class DoctorCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String availability;

  const DoctorCard({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.availability,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFFF1F1F1),
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 24.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.h)),
      elevation: 0,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 8.w),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16.w),
              child: Image.asset(
                imageUrl,
                width: 85.w,
                height: 85.h,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: Styles.textStyleInter16.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    availability,
                    style: Styles.textStyle12.copyWith(
                      color: kSecondaryColor,
                      fontFamily: 'Inter',
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          minimumSize: Size(60.w, 30.h),
                          side:
                              const BorderSide(color: kPrimaryColor, width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.h),
                          ),
                        ),
                        child: Text(
                          " More details",
                          style: Styles.textStyle12,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          minimumSize: Size(80.w, 30.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.h),
                          ),
                        ),
                        child: Text(
                          "Chat",
                          style: Styles.textStyle12.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
