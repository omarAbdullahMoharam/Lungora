class DoctorInfoModel {
  final String name;
  final int numOfPatients;
  final String about;
  final String emailDoctor;
  final String phone;
  final String teliphone;
  final int experianceYears;
  final String location;
  final String locationLink;
  final String whatsAppLink;
  final String imageDoctor;
  final double latitude;
  final double longitude;
  final String categoryName;

  DoctorInfoModel({
    required this.name,
    required this.numOfPatients,
    required this.about,
    required this.emailDoctor,
    required this.phone,
    required this.teliphone,
    required this.experianceYears,
    required this.location,
    required this.locationLink,
    required this.whatsAppLink,
    required this.imageDoctor,
    required this.latitude,
    required this.longitude,
    required this.categoryName,
  });

  factory DoctorInfoModel.fromJson(Map<String, dynamic> json) {
    return DoctorInfoModel(
      name: json['name'] ?? '',
      numOfPatients: json['numOfPatients'] ?? 0,
      about: json['about'] ?? '',
      emailDoctor: json['emailDoctor'] ?? '',
      phone: json['phone'] ?? '',
      teliphone: json['teliphone'] ?? '',
      experianceYears: json['experianceYears'] ?? 0,
      location: json['location'] ?? '',
      locationLink: json['locationLink'] ?? '',
      whatsAppLink: json['whatsAppLink'] ?? '',
      imageDoctor: json['imageDoctor'] ?? '',
      latitude: (json['latitude'] ?? 0.0).toDouble(),
      longitude: (json['longitude'] ?? 0.0).toDouble(),
      categoryName: json['categoryName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'numOfPatients': numOfPatients,
      'about': about,
      'emailDoctor': emailDoctor,
      'phone': phone,
      'teliphone': teliphone,
      'experianceYears': experianceYears,
      'location': location,
      'locationLink': locationLink,
      'whatsAppLink': whatsAppLink,
      'imageDoctor': imageDoctor,
      'latitude': latitude,
      'longitude': longitude,
      'categoryName': categoryName,
    };
  }
}
