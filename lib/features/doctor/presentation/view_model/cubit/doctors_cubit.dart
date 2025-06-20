import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lungora/core/helpers/api_services.dart';
import 'package:lungora/core/helpers/location_service.dart';
import 'package:lungora/core/utils/dependency_injection.dart';
import 'package:lungora/features/doctor/data/doctor_details_model.dart';
import 'package:lungora/features/doctor/data/doctor_model.dart';
import 'package:lungora/features/doctor/repo/doctors_repo.dart';

part 'doctors_state.dart';

class GetDoctorsCubit extends Cubit<GetDoctorsState> {
  GetDoctorsCubit() : super(GetDoctorsInitial());
  DoctorsRepo doctorsRepo = DoctorsRepo(apiServices: getIt<ApiServices>());

  Future<void> getDoctors({int? distance}) async {
    emit(GetDoctorsLoading());

    try {
      final location = await LocationService.getUserCoordinates();

      List<DoctorModel> doctorsList;

      if (location != null) {
        doctorsList = await doctorsRepo.getDoctors(
          latitude: location.latitude,
          longitude: location.longitude,
          distance: distance,
        );
      } else {
        doctorsList = await doctorsRepo.getDoctors();
      }

      doctorsList.sort((a, b) => a.name.compareTo(b.name));

      if (doctorsList.isEmpty) {
        emit(GetDoctorsEmpty());
      } else {
        emit(GetDoctorsSuccess(doctorsList: doctorsList));
      }
    } catch (e) {
      emit(GetDoctorsFailure(errMessage: e.toString()));
    }
  }

  // Future<List<DoctorModel>> getDoctorsByNearestLocation(
  //     {required double latitude, required double longitude}) async {
  //   emit(GetDoctorsLoading());
  //   try {
  //     List<DoctorModel> doctorsList =
  //         await doctorsRepo.getAllDoctorsByNearestLocation(
  //       latitude: latitude,
  //       longitude: longitude,
  //     );
  //     doctorsList.sort((a, b) => a.name.compareTo(b.name));
  //     if (doctorsList.isEmpty) {
  //       emit(GetDoctorsEmpty());
  //     } else {
  //       emit(GetDoctorsSuccess(doctorsList: doctorsList));
  //     }
  //     return doctorsList;
  //   } catch (e) {
  //     log('Error fetching nearest doctors from cubit: $e');
  //     emit(GetDoctorsFailure(errMessage: e.toString()));
  //     rethrow;
  //   }
  // }

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
