import 'package:flutter/material.dart';
import 'package:lungora/core/constants.dart';

class ScanView extends StatelessWidget {
  const ScanView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Center(
        child: Text(
          'Scan Screen',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
