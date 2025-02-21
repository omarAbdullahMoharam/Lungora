import 'package:flutter/material.dart';
import 'package:lungora/core/constants.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,

        height: double.infinity,
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: Center(
          child: Text(
            'Settings Screen',
            style: TextStyle(color: Colors.white),
          ),
        ),
        // Add more widgets for settings screen
      ),
    );
  }
}
