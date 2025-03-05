import 'package:flutter/material.dart';

class SettingOption {
  final String title;
  final IconData icon;
  final Widget? screen;
  final bool hasSwitch;
  final String path;

  const SettingOption({
    required this.title,
    required this.icon,
    required this.path,
    this.screen,
    this.hasSwitch = false,
  });
}
