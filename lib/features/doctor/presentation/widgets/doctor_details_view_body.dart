import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lungora/core/utils/styles.dart';
import '../../data/doctor_model.dart';
import 'contact_info_section.dart';
import 'doctor_info_row.dart';
import 'doctor_stats_card.dart';
import 'location_section.dart';
import 'working_time_list.dart';

class DoctorDetailsViewBody extends StatelessWidget {
  final DoctorModel doctorModel;

  const DoctorDetailsViewBody({
    super.key,
    required this.doctorModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16.h),
              child: Image.asset(
                doctorModel.imageUrl,
                height: MediaQuery.of(context).size.height * 0.38,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 50.h,
              left: 20.w,
              child: IconButton(
                onPressed: () => context.pop(),
                icon: const Icon(
                  Icons.arrow_back_ios,
                  // color: Colors.white,
                ),
              ),
            ),
            Positioned(
              left: 20.w,
              top: 200.h,
              right: 20.w,
              child: DoctorInfoRow(
                doctorModel: doctorModel,
              ),
            ),
            Positioned(
              top: 270.h,
              left: 0,
              right: 0,
              child: DoctorStatsCard(
                patients: '1000+',
                experiences: '5 Years',
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 360.h),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.black
                      : Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.w),
                    topRight: Radius.circular(50.w),
                  ),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 22.w,
                  vertical: 23,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'About doctor',
                      style: Styles.textStyle20,
                    ),
                    Text(
                      doctorModel.about,
                      style: Styles.textStyle14.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 24.h),
                    ContactInfoSection(
                      doctorModel: doctorModel,
                    ),
                    SizedBox(height: 24.h),
                    Text(
                      'Working time',
                      style: Styles.textStyle20,
                    ),
                    WorkingTimeList(
                      workingTime: doctorModel.workingTime,
                    ),
                    SizedBox(height: 24.h),
                    LocationSection(
                      doctorModel: doctorModel,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
