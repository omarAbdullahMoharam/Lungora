import 'package:lungora/features/Auth/data/models/auth_response_model.dart';
import 'package:lungora/features/auth/data/models/login_response_model.dart';

class ResponseHandler<T> {
  final bool isSuccess;
  final int? statusCode;
  final String? message;
  final List errors;
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
    List errors = const [],
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

  factory ResponseHandler.fromLoginResponse(LoginResponse response) {
    return ResponseHandler(
      isSuccess: response.isSuccess,
      statusCode: response.statusCode,
      message: response.errors.isNotEmpty ? response.errors.first : null,
      errors: response.errors,
      data: response.result as T,
    );
  }

  String get errorMessage {
    if (errors.isNotEmpty) return errors.first.toString();
    if (message != null && message!.isNotEmpty) return message!;
    return 'An unexpected error occurred';
  }

  // Get all error messages as a list
  List<String> get allErrorMessages {
    List<String> messages = [];
    if (errors.isNotEmpty) {
      messages.addAll(errors.map((e) => e.toString()));
    }
    if (message != null && message!.isNotEmpty && !messages.contains(message)) {
      messages.add(message!);
    }
    return messages;
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
    return ResponseHandler(
      isSuccess: isSuccess,
      statusCode: statusCode,
      message: message,
      errors: errors,
      data: isSuccess && data != null ? mapper(data) : null,
    );
  }
}
