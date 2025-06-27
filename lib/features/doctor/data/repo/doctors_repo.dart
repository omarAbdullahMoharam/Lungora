import 'dart:developer';
import 'package:lungora/core/helpers/api_services.dart';
import 'package:lungora/features/doctor/data/model/doctor_details_model.dart';
import 'package:lungora/features/doctor/data/model/doctor_model.dart';

class DoctorsRepo {
  ApiServices apiServices;

  DoctorsRepo({required this.apiServices});

  Future<List<DoctorModel>> getDoctors({
    double? latitude,
    double? longitude,
    int? distance,
  }) async {
    if (latitude != null && longitude != null) {
      log("🎯 Fetching nearby doctors with location: $latitude, $longitude");
      return apiServices.getAllDoctors(
        latitude: latitude,
        longitude: longitude,
        distance: distance,
      );
    } else {
      log("🌍 Fetching ALL doctors without location parameters");
      return apiServices.getAllDoctors();
    }
  }

  Future<DoctorDetailsModel> getDoctorDetails({required int id}) async {
    return apiServices.getDoctorDetails(id);
  }
}
