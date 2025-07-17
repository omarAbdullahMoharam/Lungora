import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:lungora/features/Chat/data/constant_api_secrests.dart';

class OpenRouterService {
  final Dio _dio = Dio();
  final String apiKey = ConstantApiSecrets.kApiKey;

  OpenRouterService() {
    _dio.options.baseUrl = ConstantApiSecrets.kBaseUrl;
    _dio.options.connectTimeout = Duration(seconds: 10);
    _dio.options.receiveTimeout = Duration(seconds: 60);
    _dio.options.sendTimeout = Duration(seconds: 10);
    _dio.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
      'HTTP-Referer': 'https://your-app.com', // Optional: Add your app's domain
      'X-Title': 'Your App Name', // Optional: Add your app name
    };
  }

  Future<Map<String, dynamic>> generateCompletion({
    required String prompt,
    String? model,
    Map<String, dynamic>? additionalParams,
  }) async {
    final usedModel = model ?? ConstantApiSecrets.kModelVersion;

    try {
      final payload = {
        'model': usedModel,
        'prompt': prompt,
        'max_tokens': 1000, // Add default max_tokens
        'temperature': 0.7, // Add default temperature
        ...?additionalParams,
      };

      // Debug: log the payload
      log('OpenRouter Completion Request: $payload');

      final response = await _dio.post(
        '/completions',
        data: payload,
      );

      // Debug: log the response
      log('OpenRouter Completion Response: ${response.data}');

      if (response.data is Map<String, dynamic>) {
        return response.data;
      } else {
        throw Exception(
            'Unexpected response format from OpenRouter. Response type: ${response.data.runtimeType}, Data: ${response.data}');
      }
    } on DioException catch (e) {
      log('DioException in generateCompletion: ${e.toString()}');
      log('Response data: ${e.response?.data}');
      log('Response status: ${e.response?.statusCode}');

      if (e.response != null) {
        final errorData = e.response?.data;
        if (errorData is Map<String, dynamic> &&
            errorData.containsKey('error')) {
          throw Exception(
              'OpenRouter API error: ${errorData['error']['message'] ?? errorData['error']}');
        } else {
          throw Exception(
              'OpenRouter API error (${e.response?.statusCode}): ${e.response?.data}');
        }
      } else {
        throw Exception('Failed to connect to OpenRouter: ${e.message}');
      }
    } catch (e) {
      log('Unexpected error in generateCompletion: $e');
      throw Exception('Unexpected error: $e');
    }
  }

  Future<Map<String, dynamic>> generateChatCompletion({
    required List<Map<String, String>> messages,
    String? model,
    Map<String, dynamic>? additionalParams,
  }) async {
    final usedModel = model ?? ConstantApiSecrets.kModelVersion;

    try {
      final payload = {
        'model': usedModel,
        'messages': messages,
        'max_tokens': 1000, // Add default max_tokens
        'temperature': 0.7, // Add default temperature
        ...?additionalParams,
      };

      // Debug: log the payload
      log('OpenRouter Chat Request: $payload');

      final response = await _dio.post(
        '/${ConstantApiSecrets.kApiEndpoint}', // Use the endpoint from constants
        data: payload,
      );

      // Debug: log the response
      log('OpenRouter Chat Response: ${response.data}');

      if (response.data is Map<String, dynamic>) {
        return response.data;
      } else {
        throw Exception(
            'Unexpected response format from OpenRouter. Response type: ${response.data.runtimeType}, Data: ${response.data}');
      }
    } on DioException catch (e) {
      log('DioException in generateChatCompletion: ${e.toString()}');
      log('Response data: ${e.response?.data}');
      log('Response status: ${e.response?.statusCode}');

      if (e.response != null) {
        final errorData = e.response?.data;
        if (errorData is Map<String, dynamic> &&
            errorData.containsKey('error')) {
          throw Exception(
              'OpenRouter API error: ${errorData['error']['message'] ?? errorData['error']}');
        } else {
          throw Exception(
              'OpenRouter API error (${e.response?.statusCode}): ${e.response?.data}');
        }
      } else if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('OpenRouter API request timed out: ${e.message}');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception('OpenRouter API response timed out: ${e.message}');
      } else if (e.type == DioExceptionType.sendTimeout) {
        throw Exception('OpenRouter API request timed out: ${e.message}');
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception('Please check your internet connection and try again');
      } else {
        throw Exception('Failed to connect to OpenRouter: ${e.message}');
      }
    } catch (e) {
      log('Unexpected error in generateChatCompletion: $e');
      throw Exception('Unexpected error: $e');
    }
  }

  String extractCompletionText(Map<String, dynamic> response) {
    try {
      // Handle both completion and chat completion responses
      if (response.containsKey('choices') && response['choices'] is List) {
        final choices = response['choices'] as List;
        if (choices.isNotEmpty) {
          final choice = choices[0];

          // For chat completions
          if (choice.containsKey('message') &&
              choice['message'].containsKey('content')) {
            return choice['message']['content'] ?? '';
          }

          // For completions
          if (choice.containsKey('text')) {
            return choice['text'] ?? '';
          }
        }
      }

      // If we can't extract the text, return the whole response as debug info
      log('Could not extract text from response: $response');
      return 'Error: Could not extract response text';
    } catch (e) {
      log('Error extracting completion text: $e');
      return 'Error: Failed to extract response text';
    }
  }

  // Helper method to validate API configuration
  bool validateConfiguration() {
    final apiKey = ConstantApiSecrets.kApiKey;
    final baseUrl = ConstantApiSecrets.kBaseUrl;
    final model = ConstantApiSecrets.kModelVersion;
    final endpoint = ConstantApiSecrets.kApiEndpoint;

    if (apiKey.isEmpty) {
      log('Error: API key is empty');
      return false;
    }

    if (baseUrl.isEmpty) {
      log('Error: Base URL is empty');
      return false;
    }

    if (model.isEmpty) {
      log('Error: Model version is empty');
      return false;
    }

    if (endpoint.isEmpty) {
      log('Error: API endpoint is empty');
      return false;
    }

    log('Configuration validated successfully');
    log('Base URL: $baseUrl');
    log('Model: $model');
    log('Endpoint: $endpoint');
    log('API Key: ${apiKey.substring(0, 10)}...');

    return true;
  }
}
