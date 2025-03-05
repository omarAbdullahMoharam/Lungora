import 'package:json_annotation/json_annotation.dart';

part 'login_result_model.g.dart';

@JsonSerializable(explicitToJson: true)
class LoginResultModel {
  @JsonKey(name: 'token')
  final String? token;

  @JsonKey(name: 'refreshTokenExpiration')
  final String? refreshTokenExpiration;

  LoginResultModel({
    this.token,
    this.refreshTokenExpiration,
  });

  factory LoginResultModel.fromJson(Map<String, dynamic> json) =>
      _$LoginResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResultModelToJson(this);

  // Optional utility methods
  bool get isTokenValid => token != null && token!.isNotEmpty;

  DateTime? get expirationDate {
    try {
      return refreshTokenExpiration != null
          ? DateTime.parse(refreshTokenExpiration!)
          : null;
    } catch (e) {
      return null;
    }
  }
}
