import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lungora/core/constants.dart';
import 'package:lungora/core/utils/styles.dart';
import 'package:lungora/features/doctor/presentation/view_model/cubit/doctors_cubit.dart';

class RefreshButton extends StatelessWidget {
  const RefreshButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        FocusManager.instance.primaryFocus?.unfocus();
        context.read<GetDoctorsCubit>().getDoctors(context: context);
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        minimumSize: Size(100.w, 44.h),
        backgroundColor: kPrimaryColor,
        elevation: 2,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.refresh,
            color: Colors.white,
            size: 18.sp,
          ),
          SizedBox(width: 8.w),
          Text(
            "Refresh",
            style: Styles.textStyle16.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
