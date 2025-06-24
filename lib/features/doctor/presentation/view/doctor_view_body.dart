import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lungora/core/helpers/location_service.dart';
import 'package:lungora/features/doctor/presentation/view/body_view_widgets/doctor_view_builder.dart';
import 'package:lungora/features/doctor/presentation/view_model/cubit/doctors_cubit.dart';

class DoctorViewBody extends StatefulWidget {
  const DoctorViewBody({super.key});

  @override
  State<DoctorViewBody> createState() => _DoctorViewBodyState();
}

class _DoctorViewBodyState extends State<DoctorViewBody>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _fetchDoctors();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkAndRefreshIfNeeded();
    }
  }

  void _fetchDoctors() {
    context.read<GetDoctorsCubit>().getDoctors(context: context);
  }

  Future<void> _checkAndRefreshIfNeeded() async {
    final currentState = context.read<GetDoctorsCubit>().state;

    if (currentState is GetDoctorsSuccess && !currentState.isLocationBased) {
      final hasLocationService =
          await LocationService.isLocationServiceEnabled();
      final hasLocationPermission =
          await LocationService.hasLocationPermission();

      if (hasLocationService && hasLocationPermission) {
        context.read<GetDoctorsCubit>().getDoctors(
              context: context,
              showLocationDialog: false,
            );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DoctorViewBuilder();
  }
}
