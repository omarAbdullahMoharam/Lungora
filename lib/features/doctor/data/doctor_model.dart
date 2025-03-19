import 'working_time.dart';

class DoctorModel {
  final String name;
  final String imageUrl;
  final String specialty;
  final String about;
  final String phone;
  final String email;
  final String available;
  final String location;
  final String telephone;
  final List<WorkingTime> workingTime;

  DoctorModel({
    required this.name,
    required this.imageUrl,
    required this.specialty,
    required this.about,
    required this.phone,
    required this.email,
    required this.available,
    required this.location,
    required this.telephone,
    required this.workingTime,
  });
//  factory DoctorModel.fromJson(Map<String, dynamic> json) {
//     return DoctorModel(
//       name: json['name'],
//       imageUrl: json['imageUrl'],
//       specialty: json['specialty'],
//       about: json['about'],
//       phone: json['phone'],
//       email: json['email'],
//       location: json['location'],
//       telephone: json['telephone'],
//       workingTime: (json['workingTime'] as List)
//           .map((e) => WorkingTime.fromJson(e))
//           .toList(), available: '',
//     );
//   }

// Map<String, dynamic> toJson() {
//     return {
//       'name': name,
//       'imageUrl': imageUrl,
//       'specialty': specialty,
//       'about': about,
//       'phone': phone,
//       'email': email,
//       'location': location,
//       'telephone': telephone,
//       'workingTime': workingTime.map((e) => e.toJson()).toList(),
//     };
//   }
}
