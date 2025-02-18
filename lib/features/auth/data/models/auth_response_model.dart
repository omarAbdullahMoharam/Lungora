import 'package:json_annotation/json_annotation.dart';
import 'package:lungora/features/Auth/data/models/token_result_model.dart';

part 'auth_response_model.g.dart';

@JsonSerializable()
class AuthResponse {
  final int statusCode;
  final bool isSuccess;
  final List<dynamic> errors;
  final TokenResultModel result;

  AuthResponse({
    required this.statusCode,
    required this.isSuccess,
    required this.errors,
    required this.result,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
}
