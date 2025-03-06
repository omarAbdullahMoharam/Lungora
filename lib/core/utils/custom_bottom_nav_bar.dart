import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lungora/core/utils/nav_bar_item.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const CustomBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 18.h, left: 47.w, right: 47.w),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.85,
        height: 68.h,
        decoration: BoxDecoration(
          color: const Color(0xFF5B87C5),
          borderRadius: BorderRadius.circular(34),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildNavItem(
              icon: 'assets/icon/Home.svg',
              label: 'Home',
              isSelected: selectedIndex == 0,
              onTap: () => onItemSelected(0),
            ),
            buildNavItem(
              label: 'Scan',
              icon: 'assets/icon/Camera.svg',
              isSelected: selectedIndex == 1,
              onTap: () => onItemSelected(1),
            ),
            buildNavItem(
              label: 'Settings',
              icon: 'assets/icon/Settings.svg',
              isSelected: selectedIndex == 2,
              onTap: () => onItemSelected(2),
            ),
          ],
        ),
      ),
    );
  }
}
