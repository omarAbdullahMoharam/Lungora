import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lungora/features/doctor/data/doctor_model.dart';
import 'package:lungora/features/doctor/presentation/widgets/doctor_card.dart';

class DoctorList extends StatelessWidget {
  final List<DoctorModel> doctors;

  const DoctorList({super.key, required this.doctors});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      itemCount: doctors.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: 8.h),
          child: DoctorCard(doctorModel: doctors[index]),
        );
      },
    );
  }
}
