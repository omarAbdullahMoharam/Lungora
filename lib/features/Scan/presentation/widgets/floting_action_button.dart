import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lungora/core/constants.dart';

class FlotingActionButton extends StatelessWidget {
  const FlotingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: FloatingActionButton(
        onPressed: () {},
        backgroundColor: kBackgroundColor,
        shape: CircleBorder(),
        child: SvgPicture.asset(
          'assets/icon/message.svg',
          width: 24,
          height: 24,
        ),
      ),
    );
  }
}
