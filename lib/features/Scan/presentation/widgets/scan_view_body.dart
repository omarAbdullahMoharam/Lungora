import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lungora/core/constants.dart';
import 'package:lungora/core/utils/app_router.dart';
import 'package:lungora/core/utils/styles.dart';
import 'package:lungora/core/utils/custom_elevated_button.dart';
import 'package:lungora/features/Scan/data/models/ai_model_response.dart';
import 'package:lungora/features/Scan/presentation/view_model/cubit/scan_cubit.dart';
import 'package:lungora/features/Scan/presentation/widgets/build_image_preview.dart';
import 'package:lungora/features/Scan/presentation/widgets/build_selected_image_title.dart';
import 'package:lungora/features/Scan/presentation/widgets/build_warning_banner.dart';
import 'package:lungora/features/Scan/presentation/widgets/text_with_dividers.dart';

class ScanViewBody extends StatefulWidget {
  const ScanViewBody({super.key});

  @override
  State<ScanViewBody> createState() => _ScanViewBodyState();
}

class _ScanViewBodyState extends State<ScanViewBody> {
  final ImagePicker _picker = ImagePicker();

  bool get isDisabled => context.read<ScanCubit>().imageFile == null;

  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 100,
      );

      if (pickedFile == null) {
        _showErrorToast("No image selected.");
        return;
      }

      final fileSizeInMB = await File(pickedFile.path).length() / (1024 * 1024);
      log("Picked file size: ${fileSizeInMB.toStringAsFixed(2)} MB");

      if (fileSizeInMB > 10) {
        _showErrorToast(
          "Image size exceeds 10MB. Please select a smaller image.",
        );
        return;
      }

      context.read<ScanCubit>().setImageFile(File(pickedFile.path));
      setState(() {});
    } catch (e) {
      _showErrorToast("Error picking image: ${e.toString()}");
    }
  }

  Future<void> _navigateToEditImage() async {
    if (context.read<ScanCubit>().imageFile == null) return;

    final croppedFile = await ImageCropper().cropImage(
      sourcePath: context.read<ScanCubit>().imageFile!.path,
      uiSettings: [
        AndroidUiSettings(
          showCropGrid: true,
          toolbarTitle: 'Crop Image',
          toolbarColor: kPrimaryColor,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
          statusBarColor: kPrimaryColor,
        ),
        IOSUiSettings(
          title: 'Crop Image',
        )
      ],
    );

    if (croppedFile != null) {
      context.read<ScanCubit>().setImageFile(File(croppedFile.path));
      setState(() {});
    }
  }

  Future<void> _handleScanResponse(AiModelResponse response) async {
    log("🚀 Entered _handleScanResponse with prediction: ${response.result?.predicted}");

    if (response.statusCode != 200) {
      _showErrorToast("Scan failed. Please try again.");
      return;
    }
    if (context.read<ScanCubit>().imageFile == null) {
      _showErrorToast("Image missing. Please scan again.");
      return;
    }

    if (response.result?.predicted == null) {
      _showErrorToast(
          "Unable to determine result. Please try with a clearer image.");
      context.goNamed(
        AppRouter.kUnableDetermineResult,
        extra: context.read<ScanCubit>().imageFile!,
      );
      return;
    }

    final prediction = response.result!.predicted!.toLowerCase();

    switch (prediction) {
      case 'covid':
        _showSuccessToast("COVID-19 detected ☣️🦠");
        Future.delayed(Duration.zero, () {
          if (mounted) {
            context.go(
              AppRouter.kCovid19Result,
              extra: context.read<ScanCubit>().imageFile!,
            );
          }
        });
        break;

      case 'pneumonia':
        _showSuccessToast("Pneumonia detected! 😰");
        Future.delayed(Duration.zero, () {
          if (mounted) {
            context.go(
              AppRouter.kPneumoniaResult,
              extra: context.read<ScanCubit>().imageFile!,
            );
          }
        });
        break;

      case 'normal':
        _showSuccessToast("Normal scan! 🫁🛡️");
        Future.delayed(Duration.zero, () {
          if (mounted) {
            context.go(
              AppRouter.kNormalScanResult,
              extra: context.read<ScanCubit>().imageFile!,
            );
          }
        });
        break;

      default:
        _showWarningToast(
            "Undetected result. Please consult a medical professional.");
        Future.delayed(Duration.zero, () {
          if (mounted) {
            context.go(
              AppRouter.kUnableDetermineResult,
              extra: context.read<ScanCubit>().imageFile!,
            );
          }
        });
    }
  }

  void _showErrorToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void _showSuccessToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void _showWarningToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: Colors.orange,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void _removeSelectedImage() {
    setState(() {
      context.read<ScanCubit>().setImageFile(null);
      setState(() {});
    });
  }

  Future<void> _validateAndProcessImage() async {
    final image = context.read<ScanCubit>().imageFile;
    if (image == null) {
      _showErrorToast("No image selected.");
      return;
    }
    final isValid =
        await context.read<ScanCubit>().validateImageExternally(image);
    if (isValid && mounted) {
      try {
        await context.read<ScanCubit>().processImage(image);
      } catch (e, s) {
        log("🔥 Unexpected crash: $e");
        log("🧵 Stack: $s");
        _showErrorToast("Unexpected error occurred.");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 16.h),
              child: buildImagePreview(
                selectedImage: context.read<ScanCubit>().imageFile,
                navigateToEditImage: _navigateToEditImage,
              ),
            ),
            buildWarningBanner(
              selectedImage: context.read<ScanCubit>().imageFile,
              context: context,
            ),
            SizedBox(height: 16.h),
            CustomElevatedButton(
              text: "Take Picture",
              onPressed: () => _pickImage(ImageSource.camera),
              backgroundColor: kSecondaryColor,
            ),
            SizedBox(height: 8.h),
            OutlinedButton(
              onPressed: () => _pickImage(ImageSource.gallery),
              style: OutlinedButton.styleFrom(
                minimumSize: Size(1.sw, 50.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.w),
                ),
                side: BorderSide(color: kSecondaryColor),
              ),
              child: Text(
                "Upload from device",
                style: Styles.textStyleInter16.copyWith(color: kSecondaryColor),
              ),
            ),
            buildSelectedImageTile(
              selectedImage: context.read<ScanCubit>().imageFile,
              removeSelectedImage: _removeSelectedImage,
            ),
            const TextWithDividers(
              text: 'If you finished click recognize button',
            ),
            BlocConsumer<ScanCubit, ScanState>(
              listener: (context, state) {
                if (state is ScanFailure) {
                  _showErrorToast(state.errMessage);
                } else if (state is ScanSuccess &&
                    state.modelResponse != null) {
                  if (mounted) {
                    _handleScanResponse(state.modelResponse!);
                  }
                }
              },
              builder: (context, state) {
                final bool isDisabled =
                    context.read<ScanCubit>().imageFile == null ||
                        state is ScanProccessing;
                return CustomElevatedButton(
                  isLoading: state is ScanProccessing,
                  text: "Recognize",
                  onPressed: () async {
                    if (!isDisabled) {
                      _validateAndProcessImage();
                    } else {
                      _showErrorToast("Please select an image first.");
                    }
                  },
                  backgroundColor: kPrimaryColor,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
