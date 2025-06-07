import 'dart:developer';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:lungora/core/helpers/api_services.dart';
import 'package:lungora/core/utils/dependency_injection.dart';
import 'package:lungora/features/Scan/data/models/ai_model_response.dart';
import 'package:lungora/features/Scan/data/repos/scan_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'scan_state.dart';

class ScanCubit extends Cubit<ScanState> {
  ScanCubit() : super(ScanInitial());

  // void selectImage(String imagePath) {
  //   emit(ScanImageSelected(imagePath));
  // }

  // void clearImage() {
  //   emit(ScanInitial());
  // }

  void processImage(File selectedImage) async {
    log("Image path: ${selectedImage.path}");
    // log("Token: $token");
    log("Image name: ${selectedImage.path.split('/').last}");
    log("Image size: ${selectedImage.lengthSync()} bytes");
    log('Image recognized successfully!');
    // log("\n\n\nResponse from scan view body : ${response.result} \n\n\n");
    emit(ScanProccessing());
    try {
      AiModelResponse response =
          await ScanRepo(getIt<ApiServices>()).getAIModel(image: selectedImage);

      log('Image recognized successfully!');
      if (response.statusCode == 200) {
        log("\n\n\nResponse from cubit : ${response.result} \n\n\n");
        // log("Predicted: ${response.result!.predicted}");
        if (response.result!.predicted!.isNotEmpty) {
          emit(ScanSuccess(modelResponse: response));
        } else if (response.result!.message!.isNotEmpty) {
          emit(ScanFailure(errMessage: response.result!.message!));
        }
      } else {
        log("Error: ${response.statusCode}");
        String errMessage = response.errors.isNotEmpty
            ? response.errors[0]
            : 'Failed to process image';
        log("Error message from scan_cubit: $errMessage");

        emit(
            ScanFailure(errMessage: "Process Failed. Please try again later."));
      }
    } catch (error) {
      log("Error: $error");
      emit(ScanFailure(errMessage: error.toString()));
    }
  }

  // void processImageFailure(String error) {
  //   emit(ScanFailure(errMessage: error));
  // }

  // void reset() {
  //   emit(ScanInitial());
  // }
}
