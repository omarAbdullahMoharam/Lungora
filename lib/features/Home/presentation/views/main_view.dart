import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lungora/core/utils/app_roture.dart';
import 'package:lungora/core/utils/custom_bottom_nav_bar.dart';

class MainView extends StatefulWidget {
  final Widget child;

  const MainView({
    super.key,
    required this.child,
  });

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _calculateSelectedIndex() {
    final String location = GoRouterState.of(context).matchedLocation;
    if (location.startsWith(AppRoture.kHomeView)) {
      return 0;
    }
    if (location.startsWith(AppRoture.kScanView)) {
      return 1;
    }
    if (location.startsWith(AppRoture.kSettingsView)) {
      return 2;
    }
    return 0;
  }

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        context.go(AppRoture.kHomeView);
        break;
      case 1:
        context.go(AppRoture.kScanView);
        break;
      case 2:
        context.go(AppRoture.kSettingsView);
        break;
      default:
        context.go(AppRoture.kHomeView);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _calculateSelectedIndex(),
        onItemSelected: _onItemTapped,
      ),
    );
  }
}
