import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lungora/core/constants.dart';
import 'package:lungora/core/utils/styles.dart';
import 'package:lungora/features/doctor/presentation/view_model/cubit/doctors_cubit.dart';

class LocationStatusBanner extends StatelessWidget {
  final bool isLocationBased;
  final ({double latitude, double longitude})? userLocation;

  const LocationStatusBanner({
    super.key,
    required this.isLocationBased,
    this.userLocation,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12.h),
        decoration: BoxDecoration(
          color: isLocationBased ? Colors.green.shade50 : Colors.orange.shade50,
          border: Border.all(
            color: isLocationBased ? Colors.green : kPrimaryColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  isLocationBased ? Icons.location_on : Icons.location_off,
                  color: isLocationBased ? Colors.green : kPrimaryColor,
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  isLocationBased
                      ? 'Showing nearby doctors based on your location'
                      : 'Showing all doctors (location not available)',
                  style: Styles.textStyle14.copyWith(
                    color: isLocationBased
                        ? Colors.green.shade700
                        : Colors.orange.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.start,
                  maxLines: 2,
                ),
              ),
              // Toggle button based on current state
              TextButton(
                onPressed: () {
                  if (isLocationBased) {
                    // Currently showing location-based, switch to all doctors
                    context.read<GetDoctorsCubit>().getDoctorsWithoutLocation();
                  } else {
                    // Currently showing all doctors, try to enable location
                    context.read<GetDoctorsCubit>().retryWithLocation(context);
                  }
                },
                style: TextButton.styleFrom(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: Text(
                  isLocationBased ? 'Get All Doctors' : 'Enable Location',
                  style: Styles.textStyle12.copyWith(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
