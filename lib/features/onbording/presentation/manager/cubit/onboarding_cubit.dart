import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lungora/core/utils/app_router.dart';
import 'package:lungora/features/onbording/data/models/onbording_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingInitial());
  PageController pageController = PageController();
  int indexPage = 0;
  void onClickNext(BuildContext context) async {
    if (indexPage <= data.length - 1) {
      indexPage++;
      pageController.nextPage(
        duration: const Duration(milliseconds: 2000),
        curve: Curves.fastOutSlowIn,
        //fastOutSlowIn,
        //bounceInout,
        //elasticIn  .😒
        //linear,
        // bounceOut,
      );
    }
    if (indexPage == data.length) {
      onClickSkip(context);
    }
  }

  void onClickSkip(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setBool('onboarding', true);
    if (context.mounted) {
      context.go(AppRouter.kAuthView);
    }
  }

  List data = [
    OnboardingModel(
      image: 'assets/images/onboading_3.jpg',
      title: "Your health is our priority",
      subtitle:
          "we're here to help you detect your health condition to keep you reassured ",
    ),
    OnboardingModel(
      image: 'assets/images/onboading_2.jpg',
      title: "Prevention starts with knowledge",
      subtitle:
          "Learn how to protect your lungs and recognize early symptoms of respiratory diseases through accurate medical articles ",
    ),
    OnboardingModel(
      image: 'assets/images/onboading_1.jpg',
      title: "Check Your Health in Seconds",
      subtitle:
          "Upload your X-ray image, and let us analyze it to determine if you need medical consultation ",
    ),
  ];
}
