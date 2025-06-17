import 'package:lungora/features/Settings/data/models/result_model.dart';

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
