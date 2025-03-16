import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_infi_row.dart';
import '../../data/doctor_model.dart';

class ContactInfoSection extends StatelessWidget {
  final DoctorModel doctorModel;

  const ContactInfoSection({
    super.key,
    required this.doctorModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomInfiRow(
              iconPath: 'assets/icon/call.svg',
              text: doctorModel.phone,
            ),
            CustomInfiRow(
              iconPath: 'assets/icon/empty_email.svg',
              text: doctorModel.email,
            ),
          ],
        ),
        SizedBox(height: 8.h),
        CustomInfiRow(
          iconPath: 'assets/icon/telephone.svg',
          text: doctorModel.telephone,
        ),
      ],
    );
  }
}
