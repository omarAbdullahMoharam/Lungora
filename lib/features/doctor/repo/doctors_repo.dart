import 'package:lungora/core/helpers/api_services.dart';
import 'package:lungora/features/doctor/data/doctor_model.dart';

class DoctorsRepo {
  ApiServices apiServices;
  DoctorsRepo({required this.apiServices});
  Future<List<DoctorModel>> getDoctors() async {
    // Simulate a network call or data fetching
    // In a real application, you would use Dio or another HTTP client to fetch data from an API

    // Mock data for demonstration purposes

    return apiServices.getAllDoctors();
  }
}
