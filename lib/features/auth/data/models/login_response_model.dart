import 'package:json_annotation/json_annotation.dart';
import 'package:lungora/features/auth/data/models/login_result_model.dart';

part 'login_response_model.g.dart';

@JsonSerializable(explicitToJson: true)
class LoginResponse {
  @JsonKey(name: 'statusCode')
  final int statusCode;

  @JsonKey(name: 'isSuccess')
  final bool isSuccess;

  @JsonKey(name: 'errors', defaultValue: [])
  final List<String> errors;

  @JsonKey(name: 'result')
  final LoginResultModel? result;

  LoginResponse({
    required this.statusCode,
    required this.isSuccess,
    this.errors = const [],
    this.result,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
