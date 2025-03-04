import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lungora/core/constants.dart';
import 'package:lungora/core/utils/app_roture.dart';
import 'package:lungora/core/utils/custom_appbar.dart';
import 'package:lungora/core/utils/custom_elevated_button.dart';

import '../../../Settings/presentation/widgets/custom_text_fiield.dart';

class ContactUsViewBody extends StatelessWidget {
  const ContactUsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 30.h),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30.h),
              child: CustomAppBar(
                text: 'Contact Us',
                onPressed: () {
                  GoRouter.of(context).go(AppRoture.kSettingsView);
                },
              ),
            ),
            CustomTextField(
              icon: Icons.email,
              hint: 'Email',
            ),
            SizedBox(height: 24.h),
            CustomTextField(hint: 'subject'),
            SizedBox(height: 24.h),
            CustomTextField(hint: 'Message', maxLines: 9),
            SizedBox(height: 24.h),
            CustomElevatedButton(
              text: 'Confirm',
              onPressed: () {},
              backgroundColor: kSecondaryColor,
            ),
            SizedBox(height: 24.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildCircleIcon(Icons.phone),
                SizedBox(width: 20.w),
                buildCircleIcon(Icons.email),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCircleIcon(IconData icon) {
    return Container(
      padding: EdgeInsets.all(12.h),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: kSecondaryColor, width: 2),
      ),
      child: Icon(icon, color: kSecondaryColor, size: 24),
    );
  }
}
