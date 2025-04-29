import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lungora/core/utils/styles.dart';
import 'package:lungora/features/Home/presentation/widgets/build_custom_app_bar.dart';
import 'package:lungora/features/Home/presentation/widgets/categories_section.dart';
import 'package:lungora/features/Home/presentation/widgets/services_section.dart';
import 'package:lungora/features/Settings/data/view_model/settings_cubit/settings_cubit.dart';
import 'package:lungora/features/auth/services/secure_storage_service.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  String? _userImage;

  _loadUserData() async {
    try {
      final cachedImage = await SecureStorageService.getUserImage();
      if (cachedImage != null) {
        setState(() {
          _userImage = cachedImage;
        });
        // ✅ Don't call API if cached image is available
        return;
      }

      final token = await SecureStorageService.getToken();
      if (token != null) {
        BlocProvider.of<SettingsCubit>(context).getUserData(token: token);
      }
    } catch (e) {
      log('Error loading user data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            return buildCustomAppBar(
              context: context,
              imagePath: state is SettingsGetUserDataSuccess
                  ? state.userModel.imageUser
                  : _userImage ??
                      'https://res.cloudinary.com/deoayl2hl/image/upload/v1742340954/Users/f446ff10-d23b-42ed-bb90-be18f88d9f01_2025_03_19_profile_avatar_brm2oi.jpg',
              onPressed: () async {
                String? profileImage =
                    await SecureStorageService.getUserImage();
                if (profileImage != null) {
                  // Do something with the profile image, like navigating to the profile page
                  print("Profile Image: $profileImage");
                } else {
                  print("No cached profile image found.");
                }
              },
            );
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 24.w,
          vertical: 16.h,
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.213,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF1A62FF),
                            Color(0xFF0F3B99),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(25.w),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Our Categories',
                    style: Styles.textStyle16.copyWith(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 8.h),
                  CategoriesSection(),
                  SizedBox(height: 16.h),
                  Text(
                    'Our Services',
                    style: Styles.textStyle16.copyWith(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 8.h),
                  ServicesSection(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
