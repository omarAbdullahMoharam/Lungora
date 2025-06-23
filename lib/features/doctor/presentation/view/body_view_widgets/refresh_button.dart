import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:lungora/core/constants.dart';
import 'package:lungora/core/utils/styles.dart';
import 'package:lungora/features/doctor/presentation/view_model/cubit/doctors_cubit.dart';

class RefreshButton extends StatelessWidget {
  const RefreshButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        FocusManager.instance.primaryFocus?.unfocus();

        // Try to get location permission
        await _handleLocationPermissionAndRefresh(context);
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        minimumSize: Size(100.w, 44.h),
        backgroundColor: kPrimaryColor,
        elevation: 2,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.refresh,
            color: Colors.white,
            size: 18.sp,
          ),
          SizedBox(width: 8.w),
          Text(
            "Refresh",
            style: Styles.textStyle16.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleLocationPermissionAndRefresh(BuildContext context) async {
    try {
      // Check current location permission status
      PermissionStatus locationPermission = await Permission.location.status;

      if (locationPermission.isDenied) {
        // Request location permission
        locationPermission = await Permission.location.request();
      }

      if (locationPermission.isPermanentlyDenied) {
        // Show dialog to go to settings
        _showPermissionDeniedDialog(context);
        return;
      }

      if (locationPermission.isGranted) {
        // Permission granted, refresh doctors
        context.read<GetDoctorsCubit>().getDoctors(context: context);
      } else {
        // Permission denied, show message and try to refresh anyway
        _showPermissionRequiredSnackBar(context);
        // Still try to refresh (maybe app can work without location)
        context.read<GetDoctorsCubit>().getDoctors(context: context);
      }
    } catch (e) {
      // If any error occurs, still try to refresh
      debugPrint('Error handling permission: $e');
      context.read<GetDoctorsCubit>().getDoctors(context: context);
    }
  }

  void _showPermissionDeniedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Location Permission Required',
            style: Styles.textStyle16.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'To find doctors near you, please enable location permission in your device settings.',
            style: Styles.textStyle14,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Refresh anyway without location
                context.read<GetDoctorsCubit>().getDoctors(context: context);
              },
              child: Text(
                'Continue Without Location',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Open app settings
                openAppSettings();
              },
              child: Text(
                'Open Settings',
                style: TextStyle(color: kPrimaryColor),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showPermissionRequiredSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Location permission is required to find doctors near you',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.orange,
        action: SnackBarAction(
          label: 'Settings',
          textColor: Colors.white,
          onPressed: () {
            openAppSettings();
          },
        ),
        duration: Duration(seconds: 4),
      ),
    );
  }
}
