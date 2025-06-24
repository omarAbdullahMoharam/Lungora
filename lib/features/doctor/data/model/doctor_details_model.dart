import 'package:lungora/features/doctor/data/model/doctor_info_model.dart';
import 'package:lungora/features/doctor/data/model/working_time_model.dart';

class DoctorDetailsModel {
  final DoctorInfoModel doctor;
  final List<WorkingHours> workingHours;

  DoctorDetailsModel({
    required this.doctor,
    required this.workingHours,
  });

  factory DoctorDetailsModel.fromJson(Map<String, dynamic> json) {
    return DoctorDetailsModel(
      doctor: DoctorInfoModel.fromJson(json['doctor'] ?? {}),
      workingHours: (json['workingHours'] as List<dynamic>?)
              ?.map(
                  (item) => WorkingHours.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'doctor': doctor.toJson(),
      'workingHours': workingHours.map((wh) => wh.toJson()).toList(),
    };
  }

  // Helper method to get working hours for a specific day
  WorkingHours? getWorkingHoursForDay(String day) {
    try {
      return workingHours.firstWhere(
        (wh) => wh.dayOfWeek.toLowerCase() == day.toLowerCase(),
      );
    } catch (e) {
      return null;
    }
  }

  // Helper method to check if doctor is available on a specific day
  bool isAvailableOnDay(String day) {
    return getWorkingHoursForDay(day) != null;
  }
}
