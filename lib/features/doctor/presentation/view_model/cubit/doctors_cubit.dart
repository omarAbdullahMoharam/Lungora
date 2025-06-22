import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lungora/core/helpers/api_services.dart';
import 'package:lungora/core/helpers/location_service.dart';
import 'package:lungora/core/utils/dependency_injection.dart';
import 'package:lungora/features/doctor/data/model/doctor_details_model.dart';
import 'package:lungora/features/doctor/data/model/doctor_model.dart';
import 'package:lungora/features/doctor/data/repo/doctors_repo.dart';

part 'doctors_state.dart';

class GetDoctorsCubit extends Cubit<GetDoctorsState> {
  GetDoctorsCubit() : super(GetDoctorsInitial());

  DoctorsRepo doctorsRepo = DoctorsRepo(apiServices: getIt<ApiServices>());

  Future<void> getDoctors({
    required BuildContext context,
    int? distance,
    bool showLocationDialog = true,
  }) async {
    emit(GetDoctorsLoading());

    try {
      // Get user coordinates (with proper permission handling)
      final location = await LocationService.getUserCoordinates(context);

      List<DoctorModel> doctorsList;

      if (location != null) {
        // User has location enabled and granted permission
        log("✅ Using location-based doctor fetch: ${location.latitude}, ${location.longitude}");

        doctorsList = await doctorsRepo.getDoctors(
          latitude: location.latitude,
          longitude: location.longitude,
          distance: distance,
        );

        emit(GetDoctorsLocationSuccess(
          doctorsList: doctorsList,
          userLocation: location,
          isLocationBased: true,
        ));
      } else {
        // User doesn't have location (disabled service or denied permission)
        log("⚠️ Location not available. Fetching all doctors without location.");

        doctorsList = await doctorsRepo.getDoctors();

        emit(GetDoctorsSuccess(
          doctorsList: doctorsList,
          isLocationBased: false,
        ));
      }

      // Sort doctors alphabetically
      doctorsList.sort((a, b) => a.name.compareTo(b.name));

      if (doctorsList.isEmpty) {
        emit(GetDoctorsEmpty());
      }
    } catch (e) {
      log("❌ Error fetching doctors: $e");
      emit(GetDoctorsFailure(errMessage: e.toString()));
    }
  }

  // Method to retry getting doctors with location
  Future<void> retryWithLocation(BuildContext context, {int? distance}) async {
    await getDoctors(
        context: context, distance: distance, showLocationDialog: true);
  }

  // Method to get doctors without location prompt
  Future<void> getDoctorsWithoutLocation({int? distance}) async {
    emit(GetDoctorsLoading());

    try {
      log("🔄 Fetching all doctors without location...");

      final doctorsList = await doctorsRepo.getDoctors();
      doctorsList.sort((a, b) => a.name.compareTo(b.name));

      if (doctorsList.isEmpty) {
        emit(GetDoctorsEmpty());
      } else {
        emit(GetDoctorsSuccess(
          doctorsList: doctorsList,
          isLocationBased: false,
        ));
      }
    } catch (e) {
      log("❌ Error fetching doctors without location: $e");
      emit(GetDoctorsFailure(errMessage: e.toString()));
    }
  }

  Future<DoctorDetailsModel> getDoctorDetails(int id) async {
    emit(GetDoctorsLoading());

    try {
      DoctorDetailsModel doctorDetails =
          await doctorsRepo.getDoctorDetails(id: id);
      emit(GetDoctorDetailsSuccess(doctorDetails: doctorDetails));
      return doctorDetails;
    } catch (e) {
      log('Error fetching doctor details from cubit: $e');
      emit(GetDoctorDetailsFailure(errMessage: e.toString()));
      rethrow;
    }
  }
}
