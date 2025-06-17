import 'dart:io';

import 'package:dio/dio.dart';
import 'package:lungora/core/helpers/api_services.dart';
import 'package:lungora/features/Settings/data/models/edit_info_response_model.dart';
import 'package:lungora/features/Settings/data/models/logout_response_model.dart';
import 'package:lungora/features/Settings/data/models/user_data_response_model.dart';
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

  Future<UserDataResponseModel> getUserData(String token) async {
    return _apiServices.getUserData(token);
  }

  Future<LogoutResponse> logout(String token) async {
    return _apiServices.logout(token);
  }
}

