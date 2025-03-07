import 'package:json_annotation/json_annotation.dart';
import 'package:lungora/features/auth/data/models/register_result_model.dart';

part 'change_passowrd_response_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ChangePasswordResponse {
  @JsonKey(name: 'statusCode')
  final int statusCode;

  @JsonKey(name: 'isSuccess')
  final bool isSuccess;

  @JsonKey(name: 'errors', defaultValue: [])
  final List<String> errors;

  @JsonKey(name: 'result')
  final RegisterResultModel? result;

  ChangePasswordResponse({
    required this.statusCode,
    required this.isSuccess,
    this.errors = const [],
    this.result,
  });

  factory ChangePasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChangePasswordResponseToJson(this);
}
