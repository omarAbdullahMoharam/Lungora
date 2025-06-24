import 'dart:developer';
import 'dart:io';
import 'package:http_parser/http_parser.dart';

import 'package:dio/dio.dart';
import 'package:lungora/core/helpers/api_services.dart';
import 'package:lungora/features/Scan/data/models/ai_model_response.dart';
import 'package:mime/mime.dart';

class ScanRepo {
  final ApiServices _apiServices;

  ScanRepo(this._apiServices);

  Future<AiModelResponse> getAIModel({
    required File image,
    required String token,
  }) async {
    // Create FormData for the multipart request
    final formData = FormData();

    final fileName = image.path.split('/').last;
    final mimeType = lookupMimeType(image.path);

    formData.files.add(
      MapEntry(
        'image',
        await MultipartFile.fromFile(
          image.path,
          filename: fileName,
          contentType: mimeType != null
              ? MediaType.parse(mimeType)
              : null, // Adjust content type if needed
        ),
      ),
    );
    log("formData: ${formData.toString()}from scan_repo");

    return _apiServices.getAIModel(
      formData,
      token,
    ); // Pass the token in the header
  }
}
