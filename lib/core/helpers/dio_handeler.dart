import 'package:dio/dio.dart';
import 'package:lungora/core/helpers/response_handeler.dart';

class DioErrorHandler {
  static ResponseHandler<T> handleError<T>(DioException error) {
    switch (error.type) {
      case DioExceptionType.badResponse:
        return _handleBadResponse(error.response);

      case DioExceptionType.connectionTimeout:
        return ResponseHandler.error(
          message:
              'Connection timed out. Please check your internet connection.',
        );

      case DioExceptionType.receiveTimeout:
        return ResponseHandler.error(
          message: 'Server is not responding. Please try again later.',
        );

      case DioExceptionType.sendTimeout:
        return ResponseHandler.error(
          message:
              'Failed to send request. Please check your internet connection.',
        );

      case DioExceptionType.cancel:
        return ResponseHandler.error(
          message: 'Request was cancelled',
        );

      default:
        return ResponseHandler.error(
          message: 'Network error occurred. Please try again.',
        );
    }
  }

  static ResponseHandler<T> _handleBadResponse<T>(Response? response) {
    if (response == null) {
      return ResponseHandler.error(
        message: 'No response received from server',
      );
    }

    switch (response.statusCode) {
      case 400:
        try {
          final Map<String, dynamic> data = response.data;

          // Specific handling for authentication errors
          if (data['message'] == "Email or Password is incorrect!") {
            return ResponseHandler.error(
              message: 'Invalid email or password',
              statusCode: 400,
            );
          }

          final List<String> errors = [];
          if (data['errors'] != null && data['errors'] is List) {
            errors.addAll((data['errors'] as List).map((e) => e.toString()));
          }
          if (data['message'] != null) {
            errors.add(data['message'].toString());
          }

          return ResponseHandler.error(
            message: errors.isNotEmpty ? errors[0] : errors.toString(),
            errors: errors,
            statusCode: 400,
          );
        } catch (e) {
          return ResponseHandler.error(
            message: 'Invalid request format',
            statusCode: 400,
          );
        }

      case 401:
        return ResponseHandler.error(
          message: 'Your session has expired. Please login again.',
          statusCode: 401,
        );

      case 403:
        return ResponseHandler.error(
          message: 'You don\'t have permission to access this resource.',
          statusCode: 403,
        );

      case 404:
        try {
          final Map<String, dynamic> data = response.data;
          final List<String> errors = [];
          if (data.containsKey('errors') && data['errors'] is List) {
            errors.addAll((data['errors'] as List).map((e) => e.toString()));
          }
          if (data.containsKey('message') && data['message'] is String) {
            errors.add(data['message']);
          }
          return ResponseHandler.error(
            message: errors.isNotEmpty
                ? errors.first
                : 'The requested resource was not found.',
            errors: errors,
            statusCode: 404,
          );
        } catch (e) {
          return ResponseHandler.error(
            message: 'The requested resource was not found.',
            statusCode: 404,
          );
        }

      case 500:
        return ResponseHandler.error(
          message: 'A server error occurred. Please try again later.',
          statusCode: 500,
        );

      default:
        return ResponseHandler.error(
          message: 'An unexpected error occurred. Please try again.',
          statusCode: response.statusCode,
        );
    }
  }
}
