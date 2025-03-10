import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lungora/core/constants.dart';
import 'package:lungora/core/utils/app_router.dart';
import 'package:lungora/core/utils/custom_appbar.dart';
import 'package:lungora/core/utils/custom_elevated_button.dart';
import 'package:lungora/features/Auth/Presentation/widgets/custom_text_form_field.dart';

import 'edit_profile_image.dart';

class EditProfileViewBody extends StatelessWidget {
  const EditProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 70.h,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomAppBar(
                text: "Edit Profile",
                onPressed: () {
                  GoRouter.of(context).go(AppRouter.kSettingsView);
                }),
            EditProfileImage(),
            CustomTextFormField(
              labelText: 'Username',
              isPassword: false,
              controller: TextEditingController(),
              prefixIcon: Icons.person,
              hintText: 'Username',
              autoSuggest: false,
            ),
            // SizedBox(height: 24.h),
            // CustomTextFormField(
            //   labelText: 'Phone number',
            //   isPassword: false,
            //   controller: TextEditingController(),
            //   prefixIcon: Icons.phone,
            //   hintText: 'Phone number',
            //   autoSuggest: false,
            // ),
            // SizedBox(height: 24.h),
            // CustomTextFormField(
            //   labelText: 'Email',
            //   isPassword: false,
            //   controller: TextEditingController(),
            //   prefixIcon: Icons.email,
            //   hintText: 'Email',
            //   autoSuggest: false,
            // ),
            SizedBox(height: 24.h),
            CustomElevatedButton(
              text: 'Confirm',
              onPressed: () {},
              backgroundColor: kPrimaryColor,
              height: 60,
            )
          ],
        ),
      ),
    );
  }
}
