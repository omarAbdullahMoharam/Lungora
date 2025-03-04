import 'package:flutter/material.dart';
import 'package:lungora/core/utils/app_roture.dart';
import 'package:lungora/features/Settings/presentation/view/settings_view.dart';
import 'package:lungora/features/auth/Presentation/views/forget_password_view.dart';
import 'package:lungora/features/edit_profile/presentation/widgets/edit_profile_view_body.dart';

import 'setting_options.dart';

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
      screen: SettingsView(),
      path: AppRoture.kSettingsView,
    ),
    SettingOption(
      title: "Theme",
      icon: Icons.color_lens,
      screen: SettingsView(),
      path: AppRoture.kSettingsView,
    ),
    SettingOption(
      title: "Notifications",
      icon: Icons.notifications_active,
      screen: SettingsView(),
      hasSwitch: true,
      path: AppRoture.kSettingsView,
    ),
    SettingOption(
      title: "Terms and Conditions",
      icon: Icons.description,
      screen: SettingsView(),
      path: AppRoture.kTermsConditionsView,
    ),
    SettingOption(
      title: "Privacy",
      icon: Icons.privacy_tip,
      screen: SettingsView(),
      path: AppRoture.kPrivacyView,
    ),
    SettingOption(
      title: "About us",
      icon: Icons.info,
      screen: SettingsView(),
      path: AppRoture.kAboutUsView,
    ),
    SettingOption(
      title: "Contact us",
      icon: Icons.contact_mail,
      screen: SettingsView(),
      path: AppRoture.kContactUsView,
    ),
  ];
}
