import 'package:flutter/material.dart';
import 'package:lungora/core/utils/app_roture.dart';
import 'package:lungora/features/auth/Presentation/views/forget_password_view.dart';

import '../edit_profile/edit_profile_view_body.dart';
import 'setting_options.dart';
import '../testing_screens.dart';

class SettingData {
  static final List<SettingOption> settingsItem = [
    SettingOption(
      title: "Edit Profile",
      icon: Icons.edit,
      screen: EditProfileViewBody(),
      path: AppRoture.kEditProfile,
    ),
    SettingOption(
      title: "Change Password",
      icon: Icons.lock,
      screen: ForgetPasswordView(),
      path: AppRoture.kForgetPassView,
    ),
    SettingOption(
      title: "Language",
      icon: Icons.language,
      screen: TestingScreens(),
      path: AppRoture.kSettingsView,
    ),
    SettingOption(
      title: "Theme",
      icon: Icons.color_lens,
      screen: TestingScreens(),
      path: AppRoture.kSettingsView,
    ),
    SettingOption(
      title: "Notifications",
      icon: Icons.notifications_active,
      screen: TestingScreens(),
      hasSwitch: true,
      path: AppRoture.kSettingsView,
    ),
    SettingOption(
      title: "Terms and Conditions",
      icon: Icons.description,
      screen: TestingScreens(),
      path: AppRoture.kTermsConditionsView,
    ),
    SettingOption(
      title: "Privacy",
      icon: Icons.privacy_tip,
      screen: TestingScreens(),
      path: AppRoture.kPrivacyView,
    ),
    SettingOption(
      title: "About us",
      icon: Icons.info,
      screen: TestingScreens(),
      path: AppRoture.kAboutUsView,
    ),
    SettingOption(
      title: "Contact us",
      icon: Icons.contact_mail,
      screen: TestingScreens(),
      path: AppRoture.kContactUsView,
    ),
  ];
}
