import 'package:flutter/material.dart';

import '../widgets/terms_conditions_body.dart';

class TermsConditionsView extends StatelessWidget {
  const TermsConditionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: const TermsConditionsBody(),
      ),
    );
  }
}
