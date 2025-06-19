import 'package:flutter/material.dart';
import 'package:lungora/features/doctor/data/doctor_details_model.dart';

import '../widgets/doctor_details_view_body.dart';

class DoctorDetailsView extends StatelessWidget {
  final DoctorDetailsModel doctorDetailsModel;

  const DoctorDetailsView({super.key, required this.doctorDetailsModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DoctorDetailsViewBody(doctorModel: doctorDetailsModel),
    );
  }
}
