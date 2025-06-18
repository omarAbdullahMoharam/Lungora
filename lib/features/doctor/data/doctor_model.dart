class DoctorModel {
  final int id;
  final String name;
  final String whatsAppLink;
  final String categoryName;
  final String imageDoctor;
  final String timeAvailable;

  DoctorModel({
    required this.id,
    required this.name,
    required this.whatsAppLink,
    required this.categoryName,
    required this.imageDoctor,
    required this.timeAvailable,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      whatsAppLink: json['whatsAppLink'] ?? '',
      categoryName: json['categoryName'] ?? '',
      imageDoctor: json['imageDoctor'] ?? '',
      timeAvailable: json['timeAvailable'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'whatsAppLink': whatsAppLink,
      'categoryName': categoryName,
      'imageDoctor': imageDoctor,
      'timeAvailable': timeAvailable,
    };
  }
}
