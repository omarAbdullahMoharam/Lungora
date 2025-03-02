import 'package:dio/dio.dart';
import 'package:lungora/features/Chat/data/constant_api_secrests.dart';

class OpenRouterService {
  final Dio _dio = Dio();
  final String apiKey;

  OpenRouterService({
    required this.apiKey,
  }) {
    _dio.options.baseUrl = ConstantApiSecrests.kBaseUrl;
    _dio.options.connectTimeout = Duration(seconds: 10);
    _dio.options.receiveTimeout = Duration(seconds: 60);
    _dio.options.sendTimeout = Duration(seconds: 10);
    _dio.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    };
  }

  Future<Map<String, dynamic>> generateCompletion({
    required String prompt,
    String model = ConstantApiSecrests.kModelVersion,
    Map<String, dynamic>? additionalParams,
  }) async {
    try {
      final payload = {
        'model': model,
        'messages': [
          {'role': 'user', 'content': prompt}
        ],
        ...?additionalParams,
      };

      final response = await _dio.post(
        ConstantApiSecrests.kApiEndpoint,
        data: payload,
      );

      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception('OpenRouter API error: ${e.response?.data}');
      } else {
        throw Exception('Failed to connect to OpenRouter: ${e.message}');
      }
    }
  }

  Future<Map<String, dynamic>> generateChatCompletion({
    required List<Map<String, String>> messages,
    String model = ConstantApiSecrests.kModelVersion,
    Map<String, dynamic>? additionalParams,
  }) async {
    try {
      final payload = {
        'model': model,
        'messages': messages,
        ...?additionalParams,
      };

      final response = await _dio.post(
        ConstantApiSecrests.kApiEndpoint,
        data: payload,
      );

      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception('OpenRouter API error: ${e.response?.data}');
      } else {
        throw Exception('Failed to connect to OpenRouter: ${e.message}');
      }
    }
  }

  Future<Map<String, dynamic>> generateCompletionWithRetry({
    required String prompt,
    String model = ConstantApiSecrests.kModelVersion,
    Map<String, dynamic>? additionalParams,
    int maxRetries = 3,
  }) async {
    int attempts = 0;
    DioException? lastException;

    while (attempts < maxRetries) {
      try {
        return await generateCompletion(
          prompt: prompt,
          model: model,
          additionalParams: additionalParams,
        );
      } on DioException catch (e) {
        lastException = e;
        attempts++;

        // Only retry on timeout or server errors, not on client errors
        if (e.type != DioExceptionType.receiveTimeout &&
            e.type != DioExceptionType.connectionTimeout &&
            (e.response?.statusCode ?? 0) < 500) {
          rethrow;
        }

        // Wait before retrying
        await Future.delayed(Duration(seconds: attempts));
      }
    }

    throw lastException ?? Exception('Failed after $maxRetries retries');
  }

  String extractCompletionText(Map<String, dynamic> response) {
    return response['choices'][0]['message']['content'];
  }
}
