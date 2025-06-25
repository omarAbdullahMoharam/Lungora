import 'package:flutter/material.dart';
import 'package:lungora/core/utils/styles.dart';

class BulletText extends StatelessWidget {
  final String text;

  const BulletText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '• ',
          style: Styles.textStyle10.copyWith(color: Colors.white),
        ),
        Expanded(
          child: Text(
            text,
            style: Styles.textStyle10.copyWith(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
