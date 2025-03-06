import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:lungora/core/utils/styles.dart';

class InitialEmptyChat extends StatelessWidget {
  const InitialEmptyChat({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(
          "assets/images/animatedRobot.json",
          width: 300,
          height: 200,
        ),
        Text(
          'Feel free to ask what you want 🥰',
          style: Styles.textStyle20,
        ),
      ],
    );
  }
}
