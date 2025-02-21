import 'package:flutter/material.dart';

import 'package:lungora/core/utils/styles.dart';

class CustomPasswordAppBar extends StatelessWidget {
  const CustomPasswordAppBar({
    super.key,
    required this.text,
    this.onPressed,
  });
  final String text;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: onPressed,
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
