import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lungora/features/doctor/presentation/view/body_view_widgets/doctor_list.dart';
import 'package:lungora/features/doctor/presentation/view/body_view_widgets/location_status_banner.dart';
import 'package:lungora/features/doctor/presentation/view/body_view_widgets/refresh_button.dart';
import 'package:lungora/features/doctor/presentation/view_model/cubit/doctors_cubit.dart';
import 'package:lottie/lottie.dart';

class DoctorViewBuilder extends StatelessWidget {
  const DoctorViewBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetDoctorsCubit, GetDoctorsState>(
      builder: (context, state) {
        if (state is GetDoctorsLoading) {
          return _buildLoadingState(context);
        }

        if (state is GetDoctorsFailure) {
          return _buildFailureState(context);
        }

        if (state is GetDoctorsEmpty) {
          return _buildEmptyState(context);
        }

        if (state is GetDoctorsSuccess) {
          return Column(
            children: [
              LocationStatusBanner(isLocationBased: state.isLocationBased),
              Expanded(child: DoctorList(doctors: state.doctorsList)),
            ],
          );
        }

        if (state is GetDoctorsLocationSuccess) {
          return Column(
            children: [
              LocationStatusBanner(
                isLocationBased: state.isLocationBased,
                userLocation: state.userLocation,
              ),
              Expanded(child: DoctorList(doctors: state.doctorsList)),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildLoadingState(BuildContext context) {
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

  Widget _buildFailureState(BuildContext context) {
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
          const RefreshButton(),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            "assets/animation/no_available_doctors.json",
            width: 300,
            height: 200,
          ),
          const SizedBox(height: 12),
          Text(
            "No doctors available nearby.",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 18),
          const RefreshButton(),
        ],
      ),
    );
  }
}
