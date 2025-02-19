import 'package:lungora/features/Auth/data/models/auth_response_model.dart';

class ResponseHandler<T> {
  final bool isSuccess;
  final int? statusCode;
  final String? message;
  final List<String> errors;
  final T? data;

  const ResponseHandler({
    required this.isSuccess,
    this.statusCode,
    this.message,
    this.errors = const [],
    this.data,
  });

  factory ResponseHandler.success({
    T? data,
    String? message,
    int? statusCode,
  }) {
    return ResponseHandler(
      isSuccess: true,
      data: data,
      message: message,
      statusCode: statusCode,
      errors: const [],
    );
  }

  factory ResponseHandler.error({
    String? message,
    List<String> errors = const [],
    int? statusCode,
  }) {
    return ResponseHandler(
      isSuccess: false,
      message: message,
      errors: errors,
      statusCode: statusCode,
    );
  }

  factory ResponseHandler.fromAuthResponse(AuthResponse response, {T? data}) {
    return ResponseHandler(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      message: response.message,
      errors: response.errors,
      data: data,
    );
  }

  String get errorMessage {
    if (errors.isNotEmpty) return errors.first;
    if (message != null) return message!;
    return 'An unexpected error occurred';
  }

  bool get hasErrors => errors.isNotEmpty;
  bool get hasData => data != null;

  void when({
    required Function(T? data) onSuccess,
    required Function(String message) onError,
    Function()? onLoading,
  }) {
    if (isSuccess) {
      onSuccess(data);
    } else {
      onError(errorMessage);
    }
  }

  ResponseHandler<R> map<R>(R Function(T? data) mapper) {
    return ResponseHandler<R>(
      isSuccess: isSuccess,
      statusCode: statusCode,
      message: message,
      errors: errors,
      data: isSuccess && data != null ? mapper(data) : null,
    );
  }
}
