import 'package:flutter/material.dart';
import 'package:lungora/features/Home/presentation/widgets/build_custom_app_bar.dart';
import 'package:lungora/features/Scan/presentation/widgets/scan_view_body.dart';

class ScanView extends StatelessWidget {
  const ScanView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(
        context: context,
        imagePath: 'assets/images/GoogleIcon.png',
        // ⚠️alert: onPressed body here to navigate to the profile page ⚠️
        onPressed: () {},
      ),
      body: ScanViewBody(),
    );
  }
}
