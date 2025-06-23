// ignore_for_file: unused_field

import 'dart:developer';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:lungora/core/helpers/api_services.dart';
import 'package:lungora/core/utils/dependency_injection.dart';
import 'package:lungora/features/Scan/data/models/ai_model_response.dart';
import 'package:lungora/features/Scan/data/repos/scan_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lungora/features/auth/services/secure_storage_service.dart';

part 'scan_state.dart';

class ScanCubit extends Cubit<ScanState> {
  ScanCubit() : super(ScanInitial()) {
    // Initialize dependencies in constructor
    _initializeDependencies();
  }

  late final ScanRepo _scanRepo;
  late final SecureStorageService _secureStorageService;

  // Initialize dependencies once
  void _initializeDependencies() {
    _scanRepo = ScanRepo(getIt<ApiServices>());
    _secureStorageService = getIt<SecureStorageService>();
  }

  Future<void> processImage(File selectedImage) async {
    try {
      // Validate image first
      if (!await _validateImage(selectedImage)) {
        emit(ScanFailure(errMessage: "Invalid image file"));
        return;
      }

      // Start processing
      emit(ScanProccessing());

      // Log image details
      _logImageDetails(selectedImage);

      // Get authentication token
      final token = await _getAuthToken();
      if (token == null) {
        emit(ScanFailure(
            errMessage: "User not authenticated. Please login again."));
        return;
      }

      // Process image with API
      final response =
          await _scanRepo.getAIModel(image: selectedImage, token: token);

      // Handle API response
      await _handleApiResponse(response);
    } catch (error) {
      log("Error processing image: $error");
      emit(ScanFailure(errMessage: _getErrorMessage(error)));
    }
  }

  Future<bool> _validateImage(File imageFile) async {
    try {
      // Check if file exists
      if (!await imageFile.exists()) {
        log("Image file does not exist");
        return false;
      }

      // Check file size (max 10MB)
      final fileSize = await imageFile.length();
      if (fileSize > 10 * 1024 * 1024) {
        log("Image file too large: $fileSize bytes");
        return false;
      }

      // Check if it's a valid image extension
      final extension = imageFile.path.toLowerCase().split('.').last;
      if (![
        'jpg',
        'jpeg',
        'png',
        'heic',
      ].contains(extension)) {
        log("Invalid image extension: $extension");
        return false;
      }

      return true;
    } catch (e) {
      log("Error validating image: $e");
      return false;
    }
  }

  void _logImageDetails(File selectedImage) {
    log("=== Image Processing Details ===");
    log("Image path: ${selectedImage.path}");
    log("Image name: ${selectedImage.path.split('/').last}");
    log("Image size: ${selectedImage.lengthSync()} bytes");
    log("================================");
  }

  Future<String?> _getAuthToken() async {
    try {
      final token = await SecureStorageService.getToken();
      if (token == null || token.isEmpty) {
        log("Authentication token is null or empty");
        return null;
      }
      return token;
    } catch (e) {
      log("Error getting auth token: $e");
      return null;
    }
  }

  Future<void> _handleApiResponse(AiModelResponse response) async {
    log("API Response Status Code: ${response.statusCode}");

    if (response.statusCode == 200) {
      await _handleSuccessResponse(response);
    } else {
      await _handleErrorResponse(response);
    }
  }

  Future<void> _handleSuccessResponse(AiModelResponse response) async {
    log("=== Success Response ===");
    log("Response result: ${response.result}");

    // Check if result exists and has prediction
    if (response.result?.predicted != null &&
        response.result!.predicted!.isNotEmpty) {
      log("Prediction: ${response.result!.predicted}");
      emit(ScanSuccess(modelResponse: response));
    } else if (response.result?.message != null &&
        response.result!.message!.isNotEmpty) {
      log("API returned message: ${response.result!.message}");
      emit(ScanFailure(errMessage: response.result!.message!));
    } else {
      log("No valid prediction or message in response");
      emit(ScanFailure(
          errMessage: "Unable to process image. Please try again."));
    }
  }

  Future<void> _handleErrorResponse(AiModelResponse response) async {
    log("=== Error Response ===");
    log("Status Code: ${response.statusCode}");
    log("Errors: ${response.errors}");

    String errorMessage;
    if (response.errors.isNotEmpty) {
      errorMessage = response.errors.first;
    } else {
      errorMessage = _getStatusCodeMessage(response.statusCode);
    }

    log("Final error message: $errorMessage");
    emit(ScanFailure(errMessage: errorMessage));
  }

  String _getStatusCodeMessage(int statusCode) {
    switch (statusCode) {
      case 400:
        return "Invalid request. Please check your image.";
      case 401:
        return "Authentication failed. Please login again.";
      case 403:
        return "Access denied. Please check your permissions.";
      case 404:
        return "Service not found. Please try again later.";
      case 500:
        return "Server error. Please try again later.";
      case 503:
        return "Service unavailable. Please try again later.";
      default:
        return "Process failed. Please try again later.";
    }
  }

  String _getErrorMessage(dynamic error) {
    if (error is SocketException) {
      return "No internet connection. Please check your network.";
    } else if (error is HttpException) {
      return "Network error. Please try again.";
    } else if (error is FormatException) {
      return "Invalid response format. Please try again.";
    } else {
      return "An unexpected error occurred. Please try again.";
    }
  }

  // Additional utility methods
  void scanError(String errorMessage) {
    emit(ScanFailure(errMessage: errorMessage));
  }

  void scanSuccess(AiModelResponse? response) {
    emit(ScanSuccess(modelResponse: response));
  }

  void resetScan() {
    emit(ScanInitial());
  }

  // Get current scan result if available
  AiModelResponse? get currentScanResult {
    final currentState = state;
    if (currentState is ScanSuccess) {
      return currentState.modelResponse;
    }
    return null;
  }

  // Check if currently processing
  bool get isProcessing => state is ScanProccessing;

  // Get current error message if in error state
  String? get currentError {
    final currentState = state;
    if (currentState is ScanFailure) {
      return currentState.errMessage;
    }
    return null;
  }
}
