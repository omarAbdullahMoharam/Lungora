import 'package:json_annotation/json_annotation.dart';

part 'register_result_model.g.dart';

@JsonSerializable(explicitToJson: true)
class RegisterResultModel {
  @JsonKey(name: 'token')
  final String? token;

  @JsonKey(name: 'refreshTokenExpiration')
  final String? refreshTokenExpiration;

  RegisterResultModel({
    this.token,
    this.refreshTokenExpiration,
  });

  factory RegisterResultModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterResultModelToJson(this);

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
