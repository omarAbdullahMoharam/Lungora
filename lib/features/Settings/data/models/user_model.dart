class UserModel {
  final String fullName;
  final String imageUser;

  UserModel({
    required this.fullName,
    required this.imageUser,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      fullName: json['fullName'].toString(),
      imageUser: json['imageUser'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'imageUser': imageUser,
    };
  }
}