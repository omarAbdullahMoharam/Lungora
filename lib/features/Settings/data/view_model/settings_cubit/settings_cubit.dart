import 'dart:developer';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:lungora/core/helpers/api_services.dart';
import 'package:lungora/core/helpers/dio_handeler.dart';
import 'package:lungora/features/Settings/data/repos/settings_repo.dart';
import 'package:lungora/features/auth/services/secure_storage_service.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final ApiServices _apiServices;
  SettingsCubit(this._apiServices) : super(SettingsInitial());

  Future<void> changePassword(
      String currentPassword, String newPassword, String token) async {
    log('Change Password called from settings cubit');
    log('Token: $token from settings cubit');

    if (isClosed) return;
    emit(SettingsLoading());

    try {
      final response = await SettingsRepo(_apiServices).changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
        token: token,
      );

      if (isClosed) return;

      if (response.isSuccess) {
        log('Password change successful');
        emit(SettingsSuccess(response.result!.toJson().toString()));
      } else {
        emit(
          SettingsFailure(response.errors.isNotEmpty
              ? response.errors[0]
              : 'Failed to change password'),
        );
      }
    } catch (e) {
      if (isClosed) return;

      if (e is DioException) {
        log('Settings Dio Error - Status Code: ${e.response?.statusCode}');
        log('Response Data: ${e.response?.data}');

        final errorHandler = DioErrorHandler.handleError(e);

        emit(SettingsFailure(e.response?.statusCode == 400
            ? errorHandler.errors[0]
            : errorHandler.errorMessage));
      } else {
        emit(SettingsFailure('An unexpected error occurred'));
      }
      log(e.toString());
    }
  }

  Future<void> editInfo(
      {String? username, File? image, required String token}) async {
    log('Edit Info called from settings cubit');
    log('Token: \n\n$token\n\n from settings cubit');
    log('Username: \n\n$username\n\n from settings cubit');
    log('Image: \n\n$image\n\n from settings cubit');
    if (isClosed) return;
    emit(SettingsLoading());

    try {
      final response = await SettingsRepo(_apiServices).editInfo(
        name: username,
        image: image,
        token: token,
      );

      if (isClosed) return;

      if (response.isSuccess) {
        log('Edit Info successful');
        final message = response.result!.message.isEmpty
            ? "Success"
            : response.result!.message;

        log(message);
        emit(SettingsSuccess(message));
      } else {
        emit(
          SettingsFailure(response.errors.isNotEmpty
              ? response.errors[0]
              : 'Failed to edit info'),
        );
      }
    } catch (e) {
      if (isClosed) return;

      if (e is DioException) {
        log('Settings Dio Error - Status Code: ${e.response?.statusCode}');

        final errorHandler = DioErrorHandler.handleError(e);

        emit(SettingsFailure(e.response?.statusCode == 400
            ? errorHandler.errors[0]
            : errorHandler.errorMessage));
      } else {
        emit(SettingsFailure('An unexpected error occurred'));
      }
      log(e.toString());
    }
  }

  Future<void> logout({required String token}) async {
    log('Logout called from settings cubit');
    if (isClosed) return;
    emit(SettingsLoading());

    try {
      final response = await _apiServices.logout(token);

      if (isClosed) return;

      if (response.isSuccess) {
        // Delete token and user data from secure storage
        await SecureStorageService.deleteAll();
        // Or if you prefer to be more selective:
        // await SecureStorageService.deleteToken();
        // await SecureStorageService.deleteData();
        log(response.result.message.toString());
        emit(SettingsSuccess(response.result.message.toString()));
      } else {
        emit(SettingsFailure(response.errors.isNotEmpty
            ? response.errors[0]
            : 'Failed to logout'));
      }
    } catch (e) {
      if (isClosed) return;
      log('Logout error: ${e.toString()}');
      emit(SettingsFailure('An unexpected error occurred'));
    }
  }
}

class LogoutResponse {
  final int statusCode;
  final bool isSuccess;
  final List<String> errors;
  final Result result;

  LogoutResponse({
    required this.statusCode,
    required this.isSuccess,
    required this.errors,
    required this.result,
  });

  factory LogoutResponse.fromJson(Map<String, dynamic> json) {
    return LogoutResponse(
      statusCode: json['statusCode'],
      isSuccess: json['isSuccess'],
      errors: List<String>.from(json['errors']),
      result: Result.fromJson(json['result']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'isSuccess': isSuccess,
      'errors': errors,
      'result': result.toJson(),
    };
  }
}

class Result {
  final String message;

  Result({required this.message});

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(message: json['message']);
  }

  Map<String, dynamic> toJson() {
    return {'message': message};
  }
}

// Custom exception classes
class NetworkException implements Exception {
  final String message;
  NetworkException(this.message);

  @override
  String toString() => 'NetworkException: $message';
}

class ServerException implements Exception {
  final String message;
  ServerException(this.message);

  @override
  String toString() => 'ServerException: $message';
}
