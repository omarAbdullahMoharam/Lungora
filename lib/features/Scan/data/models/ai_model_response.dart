class AiModelResponse {
  final int statusCode;
  final bool isSuccess;
  final List<String> errors;
  final ScanResult? result;

  AiModelResponse({
    required this.statusCode,
    required this.isSuccess,
    required this.errors,
    this.result,
  });

  factory AiModelResponse.fromJson(Map<String, dynamic> json) {
    return AiModelResponse(
      statusCode: json['statusCode'] as int,
      isSuccess: json['isSuccess'] as bool,
      errors: List<String>.from(json['errors']),
      result:
          json['result'] != null ? ScanResult.fromJson(json['result']) : null,
    );
  }
}

class ScanResult {
  final String? predicted;
  final String? message;

  ScanResult({this.predicted, this.message});

  factory ScanResult.fromJson(Map<String, dynamic> json) {
    return ScanResult(
      predicted: json['predicted'] as String?,
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'predicted': predicted,
      'message': message,
    };
  }
}
