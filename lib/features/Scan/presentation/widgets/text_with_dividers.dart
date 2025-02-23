import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lungora/core/utils/styles.dart';

class TextWithDividers extends StatelessWidget {
  final String text;

  const TextWithDividers({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              color: Colors.grey,
              thickness: 1,
              endIndent: 10,
            ),
          ),
          Text(
            text,
            style: Styles.textStyle12.copyWith(fontFamily: 'Inter'),
          ),
          Expanded(
            child: Divider(
              color: Colors.grey,
              thickness: 1,
              indent: 10,
            ),
          ),
        ],
      ),
    );
  }
}
