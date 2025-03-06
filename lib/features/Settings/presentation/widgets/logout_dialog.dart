import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lungora/core/constants.dart';
import 'package:lungora/core/utils/styles.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  void _exitApp(BuildContext context) {
    Navigator.of(context).pop();
    Future.delayed(Duration(milliseconds: 300), () {
      SystemNavigator.pop();
      exit(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.h),
      ),
      contentPadding: EdgeInsets.all(20.w),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.power_settings_new,
            size: 50.sp,
            color: kSecondaryColor,
          ),
          SizedBox(height: 16.h),
          Text(
            "Logout",
            textAlign: TextAlign.center,
            style: Styles.textStyle20,
          ),
          SizedBox(height: 8.h),
          Text(
            "Are you sure you want to logout?",
            style: Styles.textStyle14,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 32.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => _exitApp(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: kSecondaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.h),
                  ),
                ),
                child: Text(
                  "Confirm",
                  style: Styles.textStyleInter16.copyWith(color: Colors.white),
                ),
              ),
              SizedBox(width: 10.w),
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.h),
                  ),
                ),
                child: Text("Cancel"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
