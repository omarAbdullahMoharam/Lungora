import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lungora/core/constants.dart';
import 'package:lungora/core/utils/styles.dart';

import '../../data/doctor_model.dart';

class DoctorInfoRow extends StatelessWidget {
  final DoctorModel doctorModel;

  const DoctorInfoRow({super.key, required this.doctorModel});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                doctorModel.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Styles.textStyle24,
              ),
              Text(
                doctorModel.specialty,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Styles.textStyle14.copyWith(color: kSecondaryColor),
              ),
            ],
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16.w),
              child: Material(
                color: Colors.white,
                child: InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: EdgeInsets.all(16.h),
                    child: Icon(
                      Icons.phone_in_talk_outlined,
                      color: kPrimaryColor,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 8.w),
            ClipRRect(
              borderRadius: BorderRadius.circular(16.w),
              child: Material(
                color: kBackgroundColor,
                child: InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: EdgeInsets.all(16.h),
                    child: Icon(
                      Icons.email_outlined,
                      color: kPrimaryColor,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
