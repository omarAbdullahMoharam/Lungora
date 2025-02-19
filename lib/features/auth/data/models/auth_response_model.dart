import 'package:json_annotation/json_annotation.dart';

part 'auth_response_model.g.dart';

@JsonSerializable()
class AuthResponse {
  final bool isSuccess;
  final int statusCode;
  final List<String> errors;
  final String message;

  AuthResponse({
    required this.statusCode,
    required this.isSuccess,
    List<String>? errors,
    String? message,
  })  : errors = errors ?? [],
        message = message ?? '';

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    try {
      return _$AuthResponseFromJson(json);
    } catch (e) {
      // Fallback response if parsing fails
      return AuthResponse(
        statusCode: 500,
        isSuccess: false,
        errors: ['Error parsing response: $e'],
        message: 'Failed to process response',
      );
    }
  }

  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
}
