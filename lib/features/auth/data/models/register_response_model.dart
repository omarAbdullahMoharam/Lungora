import 'package:json_annotation/json_annotation.dart';
import 'package:lungora/features/auth/data/models/register_result_model.dart';

part 'register_response_model.g.dart';

@JsonSerializable(explicitToJson: true)
class RegisterResponse {
  @JsonKey(name: 'statusCode')
  final int statusCode;

  @JsonKey(name: 'isSuccess')
  final bool isSuccess;

  @JsonKey(name: 'errors', defaultValue: [])
  final List<String> errors;

  @JsonKey(name: 'result')
  final RegisterResultModel? result;

  RegisterResponse({
    required this.statusCode,
    required this.isSuccess,
    this.errors = const [],
    this.result,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterResponseToJson(this);
}
