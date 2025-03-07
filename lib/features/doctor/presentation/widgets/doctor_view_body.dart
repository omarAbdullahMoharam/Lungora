import 'package:flutter/material.dart';

import 'doctor_card.dart';

class DoctorViewBody extends StatelessWidget {
  const DoctorViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: 11,
      itemBuilder: (context, index) {
        return DoctorCard(
          name: 'Harucon',
          imageUrl: 'assets/images/doctor_test.jpg',
          availability: 'available from 10 AM to 4 PM',
        );
      },
    );
  }
}
