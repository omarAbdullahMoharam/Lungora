import 'package:lungora/features/Settings/data/models/user_model.dart';


class UserDataResponseModel {
  int statusCode;
  bool isSuccess;
  UserModel? userModel;
  List<String>? errors;

  UserDataResponseModel({
    required this.statusCode,
    required this.isSuccess,
    this.userModel,
    this.errors,
  }); 

  factory UserDataResponseModel.fromJson(Map<String, dynamic> json) {
    return UserDataResponseModel(
      statusCode: json['statusCode'],
      isSuccess: json['isSuccess'],
      userModel: UserModel.fromJson(json['result']),
      errors: List<String>.from(json['errors']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'isSuccess': isSuccess,
      'result': userModel?.toJson(),
      'errors': errors,
    };
  }
}