import 'package:flutter/material.dart';

import '../../data/doctor_model.dart';
import '../widgets/doctor_details_view_body.dart';

class DoctorDetailsView extends StatelessWidget {
  final DoctorModel doctorModel;

  const DoctorDetailsView({super.key, required this.doctorModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DoctorDetailsViewBody(doctorModel: doctorModel),
    );
  }
}
