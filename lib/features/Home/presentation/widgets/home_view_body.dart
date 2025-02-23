import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lungora/core/utils/styles.dart';
import 'package:lungora/features/Home/presentation/widgets/build_custom_app_bar.dart';
import 'package:lungora/features/Home/presentation/widgets/categories_section.dart';
import 'package:lungora/features/Home/presentation/widgets/services_section.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(
        context: context,
        imagePath: 'assets/images/GoogleIcon.png',
        // ⚠️alert: onPressed body here to navigate to the profile page ⚠️
        onPressed: () {},
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
