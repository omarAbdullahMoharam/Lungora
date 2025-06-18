import 'package:lungora/features/Settings/data/models/result_message.dart';

class EditInfoResponse {
  final bool isSuccess;
  final int statusCode;
  final List<String> errors;
  final ResultMessage? result;

  EditInfoResponse({
    required this.isSuccess,
    required this.statusCode,
    required this.errors,
    this.result,
  });

  factory EditInfoResponse.fromJson(Map<String, dynamic> json) {
    return EditInfoResponse(
      isSuccess: json['isSuccess'] as bool,
      statusCode: json['statusCode'] as int,
      errors: (json['errors'] as List).map((e) => e as String).toList(),
      result: json['result'] != null
          ? (json['result'] is Map
              ? ResultMessage.fromJson(json['result'])
              : ResultMessage(message: json['result'].toString()))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "isSuccess": isSuccess,
      "statusCode": statusCode,
      "errors": errors,
      "result": result?.toJson(),
    };
  }
}

