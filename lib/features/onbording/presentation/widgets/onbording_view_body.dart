import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../view_model/cubit/onboarding_cubit.dart';
import 'onbording_content.dart';

class OnbordingViewBody extends StatelessWidget {
  const OnbordingViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: BlocProvider(
              create: (context) => OnboardingCubit(),
              child: BlocBuilder<OnboardingCubit, OnboardingState>(
                builder: (context, state) {
                  OnboardingCubit cubit = context.read<OnboardingCubit>();
                  return PageView(
                    controller: cubit.pageController,
                    scrollDirection: Axis.horizontal,
                    children: List.generate(
                      cubit.data.length,
                      (index) {
                        return OnbordingContent(
                          index: index,
                          cubit: cubit,
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
