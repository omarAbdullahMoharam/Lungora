import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lungora/core/utils/styles.dart';
import 'package:lungora/core/utils/url_luncher_url.dart';
import 'package:lungora/features/doctor/data/model/doctor_info_model.dart';

class LocationSection extends StatelessWidget {
  final DoctorInfoModel doctorlocationInfo;
  const LocationSection({
    super.key,
    required this.doctorlocationInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Location',
          style: Styles.textStyle20,
        ),
        Row(
          children: [
            SvgPicture.asset(
              'assets/icon/location.svg',
              width: 24,
              height: 24,
            ),
            SizedBox(width: 8.w),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              child: Text(
                doctorlocationInfo.location,
                style: Styles.textStyle12.copyWith(color: Colors.grey),
              ),
            )
          ],
        ),
        GestureDetector(
          onTap: () {
            UrlLauncher.launchGoogleMapsFromLink(
              doctorlocationInfo.locationLink,
            );
          },
          child: Container(
            height: 150.h,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.h),
            ),
            child: Image.asset(
              'assets/images/locationnn.png',
              height: 120.h,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ],
    );
  }
}
