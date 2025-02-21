// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lungora/core/utils/styles.dart';

Widget buildNavItem({
  required String icon,
  String? label,
  required bool isSelected,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.white.withOpacity(0.2) : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            icon,
            color: Colors.white,
            width: 24,
            height: 24,
          ),
          if (label != null) ...[
            const SizedBox(width: 8),
            Text(
              textAlign: TextAlign.start,
              isSelected ? label : '',
              style: Styles.textStyle16.copyWith(
                fontFamily: 'Inter',
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ],
      ),
    ),
  );
}
