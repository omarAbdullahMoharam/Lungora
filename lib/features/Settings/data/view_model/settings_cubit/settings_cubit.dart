import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lungora/core/helpers/api_services.dart';
import 'package:dio/dio.dart';
import 'package:lungora/core/helpers/dio_handeler.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final ApiServices _apiServices;
  SettingsCubit(this._apiServices) : super(SettingsInitial());

  Future<void> changePassword(
      String currentPassword, String newPassword, String token) async {
    log('Change Password called from settings cubit');
    log('Token: $token from settings cubit');

    emit(SettingsLoading());
    try {
      final response = await _apiServices.changePassword({
        'currentPassword': currentPassword,
        'newPassword': newPassword,
      }, token);

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

//  TODO: implement edit profile method for the settings cubit to edit the user profile
  // Future<void> editProfile() async {}
  // TODO: Implement logout method for the settings cubit to log out the user from the app using token
  // Future<void> logout() async {}
}
