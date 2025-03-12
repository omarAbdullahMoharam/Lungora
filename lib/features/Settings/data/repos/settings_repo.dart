import 'package:lungora/core/helpers/api_services.dart';
import 'package:lungora/features/Settings/data/view_model/settings_cubit/settings_cubit.dart';
import 'package:lungora/features/auth/data/models/change_passowrd_response_model.dart';
import 'package:lungora/features/auth/data/models/register_result_model.dart';

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

  Future<LogoutResponse> editInfo({
    String? name,
    String? image,
    required String token,
  }) async {
    return _apiServices.editInfo({
      "FullName": name,
      'ImageUser': image ?? '',
    }, token);
  }

  Future<LogoutResponse> logout(String token) async {
    return _apiServices.logout(token);
  }
}

// class EditInfoResponse {
//   final bool isSuccess;
//   final int statusCode;
//   final List<String> errors;
//   final Result? result;

//   EditInfoResponse({
//     required this.statusCode,
//     required this.errors,
//     required this.result,
//     required this.isSuccess,
//   });

//   factory EditInfoResponse.fromJson(Map<String, dynamic> json) {
//     return EditInfoResponse(
//       isSuccess: json['isSuccess'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       "isSuccess": isSuccess,
//     };
//   }
// }
