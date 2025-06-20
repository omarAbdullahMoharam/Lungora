import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:lungora/core/constants.dart';
import 'package:lungora/core/utils/styles.dart';
import 'package:lungora/features/doctor/data/doctor_model.dart';
import 'package:lungora/features/doctor/presentation/view_model/cubit/doctors_cubit.dart';
import 'doctor_card.dart';

class DoctorViewBody extends StatefulWidget {
  const DoctorViewBody({super.key});

  @override
  State<DoctorViewBody> createState() => _DoctorViewBodyState();
}

class _DoctorViewBodyState extends State<DoctorViewBody> {
  @override
  void initState() {
    super.initState();

    // Fetch doctors when the widget is initialized
    context.read<GetDoctorsCubit>().getDoctors();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetDoctorsCubit, GetDoctorsState>(
      builder: (context, state) {
        if (state is GetDoctorsLoading) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  "assets/animation/searching.json",
                  width: 300,
                  height: 200,
                ),
                const SizedBox(height: 20),
                Text(
                  "Finding nearest doctor for you...",
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }

        if (state is GetDoctorsFailure) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  "assets/animation/no_available_doctors.json",
                  width: 300,
                  height: 200,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Sorry, we couldn't fetch the doctors right now.",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () async {
                    FocusManager.instance.primaryFocus?.unfocus();
                    context.read<GetDoctorsCubit>().getDoctors();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.w),
                    ),
                    minimumSize: Size(80, 40.h),
                    backgroundColor: kPrimaryColor,
                  ),
                  child: Text(
                    "Refresh",
                    style: Styles.textStyle16.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        if (state is GetDoctorsEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  "assets/animation/no_available_doctors.json",
                  width: 300,
                  height: 200,
                ),
                SizedBox(height: 8.h),
                Text(
                  "No doctors available nearby.",
                  style: Styles.textStyle14.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 18),
                ElevatedButton(
                  onPressed: () async {
                    FocusManager.instance.primaryFocus?.unfocus();
                    context.read<GetDoctorsCubit>().getDoctors();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.w),
                    ),
                    minimumSize: Size(80.w, 40.h),
                    backgroundColor: kPrimaryColor,
                  ),
                  child: Text(
                    "Refresh",
                    style: Styles.textStyle16.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        if (state is GetDoctorsSuccess) {
          return _buildDoctorsList(state.doctorsList);
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildDoctorsList(List<DoctorModel> doctors) {
    return ListView.builder(
      itemCount: doctors.length,
      itemBuilder: (context, index) {
        return DoctorCard(doctorModel: doctors[index]);
      },
    );
  }
}
