import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lungora/core/utils/styles.dart';

import '../view_model/cubit/onboarding_cubit.dart';

class OnbordingContent extends StatelessWidget {
  final int index;
  final OnboardingCubit cubit;

  const OnbordingContent({
    super.key,
    required this.cubit,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OnboardingCubit>.value(
      value: cubit,
      child: BlocBuilder<OnboardingCubit, OnboardingState>(
        builder: (context, state) {
          return Scaffold(
            body: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    cubit.data[index].image,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned.fill(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        cubit.data[index].title,
                        style: Styles.textStyle20.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.h),
                        child: Text(
                          cubit.data[index].subtitle,
                          textAlign: TextAlign.center,
                          style: Styles.textStyle16.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // زر Skip
                Positioned(
                  top: 50,
                  right: 20,
                  child: TextButton(
                    onPressed: () {
                      cubit.onClickSkip(context);
                    },
                    child: Text(
                      "Skip",
                      style: Styles.textStyle14.copyWith(
                        color: Colors.white,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 50,
                  right: 20,
                  child: TextButton(
                    onPressed: () {
                      cubit.onClickNext(context);
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Next',
                          style: Styles.textStyle14.copyWith(
                            color: Colors.white,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Icon(Icons.east, size: 20, color: Colors.white),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
