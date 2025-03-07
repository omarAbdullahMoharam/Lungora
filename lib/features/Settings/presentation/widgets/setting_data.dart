import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lungora/core/utils/app_router.dart';
import 'package:lungora/features/Settings/presentation/view/change_password/views/change_password_view.dart';

import 'package:lungora/features/Settings/presentation/view/settings_view.dart';
import 'package:lungora/features/edit_profile/presentation/widgets/edit_profile_view_body.dart';

import 'package:lungora/features/auth/Presentation/view_models/auth_cubit/auth_cubit.dart';
import 'package:lungora/features/Auth/data/repos/auth_repo.dart';

import '../../../../../core/utils/dependency_injection.dart';

import 'setting_options.dart';

class SettingData {
  static final List<SettingOption> settingsItem = [
    SettingOption(
      title: "Edit Profile",
      icon: Icons.edit,
      screen: EditProfileViewBody(),
      path: AppRouter.kEditProfile,
    ),
    SettingOption(
      title: "Change Password",
      icon: Icons.lock,
      screen: BlocProvider(
        create: (context) => AuthCubit(getIt<AuthRepo>()),
        child: ChangePasswordView(),
      ),
      path: AppRouter.kChangePasswordView,
    ),
    SettingOption(
      title: "Language",
      icon: Icons.language,
      screen: SettingsView(),
      path: AppRouter.kSettingsView,
    ),
    SettingOption(
      title: "Theme",
      icon: Icons.color_lens,
      screen: SettingsView(),
      path: AppRouter.kSettingsView,
    ),
    SettingOption(
      title: "Notifications",
      icon: Icons.notifications_active,
      screen: SettingsView(),
      hasSwitch: true,
      path: AppRouter.kSettingsView,
    ),
    SettingOption(
      title: "Terms and Conditions",
      icon: Icons.description,
      screen: SettingsView(),
      path: AppRouter.kTermsConditionsView,
    ),
    SettingOption(
      title: "Privacy",
      icon: Icons.privacy_tip,
      screen: SettingsView(),
      path: AppRouter.kPrivacyView,
    ),
    SettingOption(
      title: "About us",
      icon: Icons.info,
      screen: SettingsView(),
      path: AppRouter.kAboutUsView,
    ),
    SettingOption(
      title: "Contact us",
      icon: Icons.contact_mail,
      screen: SettingsView(),
      path: AppRouter.kContactUsView,
    ),
  ];
}
