import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lungora/core/utils/styles.dart';
import '../widgets/setting/setting_view_body.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          elevation: 0,
          scrolledUnderElevation: 0,
          flexibleSpace: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Lungora',
                  style: Styles.textStyle20.copyWith(
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Inter',
                    height: 2.sp,
                    color: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .color, // لون النص يعتمد على الثيم
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.notifications_active,
                    size: 26,
                    color: Theme.of(context)
                        .iconTheme
                        .color, // لون الأيقونة يعتمد على الثيم
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
        body: const SettingViewBody(),
      ),
    );
  }
}
