import 'package:lungora/core/helpers/api_services.dart';
import 'package:lungora/features/doctor/data/doctor_details_model.dart';
import 'package:lungora/features/doctor/data/doctor_model.dart';

class DoctorsRepo {
  ApiServices apiServices;

  DoctorsRepo({required this.apiServices});

  Future<List<DoctorModel>> getDoctors({
    double? latitude,
    double? longitude,
    int? distance,
  }) async {
    return apiServices.getAllDoctors(
      latitude: latitude,
      longitude: longitude,
      distance: distance,
    );
  }

  Future<DoctorDetailsModel> getDoctorDetails({required int id}) async {
    return apiServices.getDoctorDetails(id);
  }

  // Future<List<DoctorModel>> getAllDoctorsByNearestLocation({
  //   required double latitude,
  //   required double longitude,
  // }) async {
  //   return apiServices.getAllDoctorsByNearestLocation(
  //     latitude: latitude,
  //     longitude: longitude,
  //   );
  // }
}
