import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lungora/core/constants.dart';
import 'package:lungora/core/utils/styles.dart';
import 'package:lungora/features/Settings/presentation/widgets/setting/setting_list_view.dart';

import '../logout_dialog.dart';

class SettingViewBody extends StatelessWidget {
  const SettingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 24.w,
        vertical: 24.h,
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              // const Color(0xFFF5F9FC),
              child: const SettingListView(),
            ),
          ),
          SizedBox(height: 24.h),
          OutlinedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const LogoutDialog(),
              );
            },
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: kSecondaryColor, width: 2),
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 44.w),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.h),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.power_settings_new,
                  color: kSecondaryColor,
                  size: 26,
                ),
                SizedBox(width: 8.w),
                Text(
                  "Logout",
                  style: Styles.textStyle16,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
