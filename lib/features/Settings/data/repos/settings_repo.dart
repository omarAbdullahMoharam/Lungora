import 'dart:io';

import 'package:dio/dio.dart';
import 'package:lungora/core/helpers/api_services.dart';
import 'package:lungora/features/Settings/data/view_model/settings_cubit/settings_cubit.dart';
import 'package:lungora/features/auth/data/models/change_passowrd_response_model.dart';

class SettingsRepo {
  final ApiServices _apiServices;

  SettingsRepo(this._apiServices);
  Future<ChangePasswordResponse> changePassword(
      {required String currentPassword,
      required String newPassword,
      required String token}) async {
    return _apiServices.changePassword({
      "currentPassword": currentPassword,
      "newPassword": newPassword,
    }, token);
  }

  Future<EditInfoResponse> editInfo({
    String? name,
    File? image,
    required String token,
  }) async {
    // Create FormData for the multipart request
    final formData = FormData();

    // Add name to the request if provided
    if (name != null) {
      formData.fields.add(MapEntry('FullName', name));
    }

    // Add image to the request if provided
    if (image != null) {
      final fileName = image.path.split('/').last;
      formData.files.add(
        MapEntry(
          'ImageUser',
          await MultipartFile.fromFile(
            image.path,
            filename: fileName,
          ),
        ),
      );
    }

    return _apiServices.editInfo(formData, token);
  }

  Future<LogoutResponse> logout(String token) async {
    return _apiServices.logout(token);
  }
}

class EditInfoResponse {
  final bool isSuccess;
  final int statusCode;
  final List<String> errors;
  final ResultMessage? result;

  EditInfoResponse({
    required this.isSuccess,
    required this.statusCode,
    required this.errors,
    this.result,
  });

  factory EditInfoResponse.fromJson(Map<String, dynamic> json) {
    return EditInfoResponse(
      isSuccess: json['isSuccess'] as bool,
      statusCode: json['statusCode'] as int,
      errors: (json['errors'] as List).map((e) => e as String).toList(),
      result: json['result'] != null
          ? (json['result'] is Map
              ? ResultMessage.fromJson(json['result'])
              : ResultMessage(message: json['result'].toString()))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "isSuccess": isSuccess,
      "statusCode": statusCode,
      "errors": errors,
      "result": result?.toJson(),
    };
  }
}

class ResultMessage {
  final String message;

  ResultMessage({required this.message});

  factory ResultMessage.fromJson(Map<String, dynamic> json) {
    return ResultMessage(
      message: json['message'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "message": message,
    };
  }
}
