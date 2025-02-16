import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lungora/core/utils/styles.dart';

import '../../../../core/utils/app_roture.dart' show AppRoture;

class CustomPasswordAppBar extends StatelessWidget {
  const CustomPasswordAppBar({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            context.go(AppRoture.kAuthView);
          },
          icon: Icon(
            Icons.arrow_back_ios_outlined,
            size: 30,
          ),
        ),
        Text(
          text,
          style: Styles.textStyle20,
        ),
      ],
    );
  }
}
