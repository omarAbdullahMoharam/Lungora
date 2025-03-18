import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lungora/features/doctor/presentation/widgets/doctor_view_body.dart';

class DoctorView extends StatelessWidget {
  const DoctorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: DoctorViewBody(),
    );
  }
}
