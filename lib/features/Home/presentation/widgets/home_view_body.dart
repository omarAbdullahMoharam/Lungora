import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lungora/core/helpers/api_services.dart';
import 'package:lungora/core/utils/app_router.dart';
import 'package:lungora/core/utils/dependency_injection.dart';
import 'package:lungora/core/utils/styles.dart';
import 'package:lungora/features/Home/presentation/widgets/build_custom_app_bar.dart';
import 'package:lungora/features/Home/presentation/widgets/categories_section.dart';
import 'package:lungora/features/Home/presentation/widgets/services_section.dart';
import 'package:lungora/features/Settings/data/view_model/settings_cubit/settings_cubit.dart';
import 'package:lungora/features/auth/services/secure_storage_service.dart';
import 'package:lungora/features/diseases/data/repo/disease_repo.dart';
import 'package:lungora/features/diseases/presentation/view_model/categories/categories_cubit.dart';
import 'package:lungora/features/diseases/presentation/widgets/all_categories_view_body.dart';

import 'lung_info_content.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  // ignore: unused_field
  String? _userImage;

  _loadUserData() async {
    try {
      final cachedImage = await SecureStorageService.getUserImage();
      if (cachedImage != null) {
        if (!mounted) return;
        setState(() {
          _userImage = cachedImage;
        });
        return;
      }

      final token = await SecureStorageService.getToken();
      if (token != null) {
        if (!mounted) return;
        if (context.mounted) {
          BlocProvider.of<SettingsCubit>(context, listen: false)
              .getUserData(token: token);
        }
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
                title: 'Lungora',
                showProfileImage: true,
                onProfilePressed: () {
                  context.go(AppRouter.kSettingsView);
                },
              );
            },
          )),
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
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.213,
                      child: const LungInfoContent(),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      Text(
                        'Our Categories',
                        style: Styles.textStyle16.copyWith(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      Spacer(),
                      TextButton(
                        onPressed: () {
                          DiseaseRepo diseaseRepo =
                              DiseaseRepo(getIt<ApiServices>());

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                create: (context) =>
                                    CategoriesCubit(diseaseRepo)
                                      ..getAllCategories(),
                                child: const AllCategoriesViewBody(),
                              ),
                            ),
                          );
                        },
                        child: Text(
                          'See All',
                          style: Styles.textStyle14.copyWith(
                            fontFamily: 'Montserrat',
                            color: Color(0xFF1A62FF),
                          ),
                        ),
                      ),
                    ],
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
