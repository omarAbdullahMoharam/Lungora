import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lungora/core/utils/styles.dart';
import 'bullet_text.dart';

class LungInfoContent extends StatelessWidget {
  const LungInfoContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1A62FF),
            Color(0xFF0F3B99),
          ],
        ),
        borderRadius: BorderRadius.circular(25.w),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -70.w,
            bottom: -90.h,
            top: -80.h,
            child: Opacity(
              opacity: 0.25,
              child: Image.asset(
                'assets/icon/lung_app_OUT_FONT_PNG-removebg.png',
                //'assets/images/logo_lung_for_home_a_-removebg-preview.png',
                fit: BoxFit.fill,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Breathe Easy – Your AI Lung Health Assistant',
                style: Styles.textStyle12.copyWith(
                  color: Colors.white,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: 8.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BulletText(
                          text: 'Analyze your chest X-rays instantly using AI.',
                        ),
                        SizedBox(height: 5.h),
                        BulletText(
                          text: 'Get personalized treatment suggestions.',
                        ),
                        SizedBox(height: 5.h),
                        BulletText(
                          text:
                              'Connect directly with certified lung specialists.',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 100.w),

                  // Align(
                  //   alignment: Alignment.bottomRight,
                  //   child: ElevatedButton(
                  //     onPressed: () {
                  //       // Navigate
                  //     },
                  //     style: ElevatedButton.styleFrom(
                  //       backgroundColor: Color(0xFF1A62FF),
                  //       foregroundColor: Colors.white,
                  //       // shape: RoundedRectangleBorder(
                  //       //   borderRadius:
                  //       //       BorderRadius.circular(16.w),
                  //       // ),
                  //     ),
                  //     child: Text(
                  //       'How It Works',
                  //       style: TextStyle(fontSize: 12.sp),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
