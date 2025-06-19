import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lungora/core/constants.dart';
import 'package:lungora/core/utils/styles.dart';
import 'package:lungora/core/utils/url_luncher_url.dart';
import 'package:lungora/features/doctor/data/doctor_details_model.dart';

class DoctorInfoRow extends StatelessWidget {
  final DoctorDetailsModel doctorModel;

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
                doctorModel.doctor.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Styles.textStyle24,
              ),
              Text(
                doctorModel.doctor.categoryName,
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
                  onTap: () {
                    UrlLauncher.launchPhoneDialer(doctorModel.doctor.phone);
                  },
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
                  onTap: () {
                    UrlLauncher.launchWhatsApp(doctorModel.doctor.phone);
                  },
                  child: Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.w),
                    child: Padding(
                      padding: EdgeInsets.all(16.h),
                      child: SvgPicture.asset(
                        'assets/icon/whatsapp.svg',
                        color: kPrimaryColor,
                        width: 20.w,
                        height: 20.h,
                      ),
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
