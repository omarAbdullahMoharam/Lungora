import 'package:flutter/material.dart';
import 'package:lungora/features/Home/presentation/widgets/build_custom_app_bar.dart';
import '../widgets/setting_view_body.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        extendBodyBehindAppBar: true,
        appBar: buildCustomAppBar(
          context: context,
          title: 'Lungora',
          showProfileImage: true,
          onProfilePressed: () {
            Navigator.of(context).pushNamed('/settings');
          },
        ),
        body: const SettingViewBody(),
      ),
    );
  }
}
