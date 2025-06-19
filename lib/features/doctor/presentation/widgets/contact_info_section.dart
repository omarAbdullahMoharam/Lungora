import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lungora/features/doctor/data/doctor_info_model.dart';
import 'package:lungora/features/doctor/presentation/widgets/custom_infi_row.dart';

class ContactInfoSection extends StatelessWidget {
  final DoctorInfoModel doctorInfoModel;

  const ContactInfoSection({
    super.key,
    required this.doctorInfoModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomInfoRow(
              iconPath: 'assets/icon/call.svg',
              text: doctorInfoModel.phone,
            ),
            CustomInfoRow(
              isEmail: true,
              iconPath: 'assets/icon/empty_email.svg',
              text: doctorInfoModel.emailDoctor,
            ),
          ],
        ),
        SizedBox(height: 8.h),
        CustomInfoRow(
          iconPath: 'assets/icon/telephone.svg',
          text: doctorInfoModel.teliphone,
        ),
      ],
    );
  }
}
