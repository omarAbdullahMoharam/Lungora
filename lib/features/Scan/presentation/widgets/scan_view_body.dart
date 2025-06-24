<<<<<<< HEAD
// ignore_for_file: unused_element

import 'package:dotted_border/dotted_border.dart';
=======
import 'dart:developer';
import 'dart:io';

>>>>>>> Scan
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
<<<<<<< HEAD
=======
import 'package:image_cropper/image_cropper.dart';
>>>>>>> Scan
import 'package:image_picker/image_picker.dart';
import 'package:lungora/core/constants.dart';
import 'package:lungora/core/utils/app_router.dart';
<<<<<<< HEAD
import 'package:lungora/core/helpers/api_services.dart';
import 'package:lungora/core/utils/dependency_injection.dart';
=======
>>>>>>> Scan
import 'package:lungora/core/utils/styles.dart';
import 'package:lungora/core/utils/custom_elevated_button.dart';
import 'package:lungora/features/Scan/data/models/ai_model_response.dart';
import 'package:lungora/features/Scan/presentation/view_model/cubit/scan_cubit.dart';
import 'package:lungora/features/Scan/presentation/widgets/build_image_preview.dart';
import 'package:lungora/features/Scan/presentation/widgets/build_selected_image_title.dart';
import 'package:lungora/features/Scan/presentation/widgets/build_warning_banner.dart';
import 'package:lungora/features/Scan/presentation/widgets/text_with_dividers.dart';
// import 'package:lungora/features/auth/services/secure_storage_service.dart';

class ScanViewBody extends StatefulWidget {
  const ScanViewBody({super.key});

  @override
  State<ScanViewBody> createState() => _ScanViewBodyState();
}

class _ScanViewBodyState extends State<ScanViewBody> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();
  // ignore: unused_field
  late final ScanRepo _scanRepo;

  @override
  void initState() {
    super.initState();
    _scanRepo = ScanRepo(getIt<ApiServices>());
  }

  bool get isDisabled => _selectedImage == null;

  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(
        source: source,
<<<<<<< HEAD
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      _showErrorSnackBar("Error picking image: ${e.toString()}");
    }
  }

  Future<bool> _validateImage(File image) async {
    final fileSize = await image.length();
    if (fileSize > 10 * 1024 * 1024) {
      _showErrorSnackBar("Image size exceeds 10 MB limit.");
      return false;
=======
        imageQuality: 85,
      );

      if (pickedFile == null) {
        Fluttertoast.showToast(
          msg: "No image selected.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
        );
        return;
      }

      final fileSizeInMB = await File(pickedFile.path).length() / (1024 * 1024);
      log("Picked file size: ${fileSizeInMB.toStringAsFixed(2)} MB");

      if (fileSizeInMB > 10) {
        Fluttertoast.showToast(
          msg: "Image is too large. Image size must be less than 10MB.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
        );
        return;
      }

      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    } catch (e) {
      _showErrorSnackBar("Error picking image: ${e.toString()}");
    }
  }

  Future<void> _navigateToEditImage() async {
    if (_selectedImage == null) return;

    final croppedFile = await ImageCropper().cropImage(
      sourcePath: _selectedImage!.path,
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
      setState(() {
        _selectedImage = File(croppedFile.path);
      });
    }
  }

  Future<void> _handleScanResponse(AiModelResponse response) async {
    if (response.statusCode != 200) {
      _showErrorSnackBar("Scan failed. Please try again.");
      return;
    }

    if (response.result?.predicted == null) {
      _showErrorSnackBar(
          "Unable to determine result. Please try with a clearer image.");
      context.go(AppRouter.kUnableDetermineResult);
      return;
    }

    final prediction = response.result!.predicted!.toLowerCase();

    switch (prediction) {
      case 'covid':
        _showSuccessSnackBar("COVID-19 detected ☣️🦠");
        context.go(AppRouter.kCovid19Result);
        break;
      case 'pneumonia':
        _showSuccessSnackBar("Pneumonia detected! 😰");
        context.go(AppRouter.kCovid19Result);
        break;
      case 'normal':
        _showSuccessSnackBar("Normal scan! 🫁🛡️");
        context.go(AppRouter.kNormalScanResult);
        break;
      default:
        _showWarningSnackBar(
            "Undetected result. Please consult a medical professional.");
        context.go(AppRouter.kUnableDetermineResult);
    }
  }

  void _showErrorSnackBar(String message) =>
      _showSnackBar(message, Colors.red, Icons.error);
  void _showSuccessSnackBar(String message) =>
      _showSnackBar(message, Colors.green, Icons.check_circle);
  void _showWarningSnackBar(String message) =>
      _showSnackBar(message, Colors.orange, Icons.warning);

  void _showSnackBar(String message, Color color, IconData icon) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Colors.white),
            SizedBox(width: 8.w),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: color,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _removeSelectedImage() {
    setState(() {
      _selectedImage = null;
    });
  }

  Future<void> _validateAndProcessImage() async {
    final isValid = await context
        .read<ScanCubit>()
        .validateImageExternally(_selectedImage!);
    if (isValid && mounted) {
      context.read<ScanCubit>().processImage(_selectedImage!);
>>>>>>> Scan
    }
    return true;
  }

  Future<void> _handleScanResponse(AiModelResponse response) async {
    if (response.statusCode != 200) {
      _showErrorSnackBar("Scan failed. Please try again.");
      return;
    }

    if (response.result?.predicted == null) {
      _showErrorSnackBar(
          "Unable to determine result. Please try with a clearer image.");
      context.go(AppRouter.kUnableDetermineResult);
      return;
    }

    final prediction = response.result!.predicted!.toLowerCase();

    switch (prediction) {
      case 'covid':
        _showSuccessSnackBar("COVID-19 detected ☣️🦠");
        context.go(AppRouter.kCovid19Result);
        break;
      case 'pneumonia':
        _showSuccessSnackBar("Pneumonia detected! 😰");
        context.go(AppRouter.kCovid19Result);
        break;
      case 'normal':
        _showSuccessSnackBar("Normal scan! 🫁🛡️");
        context.go(AppRouter.kNormalScanResult);
        break;
      default:
        _showWarningSnackBar(
            "Undetected result. Please consult a medical professional.");
        context.go(AppRouter.kUnableDetermineResult);
    }
  }

  void _showErrorSnackBar(String message) {
    _showSnackBar(message, Colors.red, Icons.error);
  }

  void _showSuccessSnackBar(String message) {
    _showSnackBar(message, Colors.green, Icons.check_circle);
  }

  void _showWarningSnackBar(String message) {
    _showSnackBar(message, Colors.orange, Icons.warning);
  }

  void _showSnackBar(String message, Color color, IconData icon) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Colors.white),
            SizedBox(width: 8.w),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: color,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _removeSelectedImage() {
    setState(() {
      _selectedImage = null;
    });
  }

  Widget _buildImagePreview() {
    return BlocBuilder<ScanCubit, ScanState>(
      builder: (context, state) {
        if (_selectedImage == null) {
          return _buildPlaceholderImage();
        }

        if (state is ScanProccessing) {
          return _buildProcessingImage();
        }

        return _buildSelectedImage();
      },
    );
  }

  Widget _buildPlaceholderImage() {
    return Container(
      height: 290.h,
      width: 250.w,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Image.asset(
        'assets/images/lung_scan.png',
        height: 290.h,
        width: 230.w,
        fit: BoxFit.fill,
      ),
    );
  }

  Widget _buildSelectedImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.file(
        _selectedImage!,
        height: 290.h,
        width: 250.w,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildProcessingImage() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.file(
            _selectedImage!,
            height: 290.h,
            width: 250.w,
            fit: BoxFit.cover,
          ),
        ),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              color: kSecondaryColor.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: LottieBuilder.asset(
                'assets/animation/Animation-Proccessing.json',
                height: 100.h,
                width: 100.w,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWarningBanner() {
    if (_selectedImage != null) return const SizedBox.shrink();

    return Container(
      height: 70.h,
      decoration: BoxDecoration(
        color: kSecondaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16.w),
      ),
      child: DottedBorder(
        options: RoundedRectDottedBorderOptions(
          strokeWidth: 2.w,
          dashPattern: [8, 4],
          color: Colors.amber.shade400,
          radius: Radius.circular(16.w),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: FaIcon(
              FontAwesomeIcons.triangleExclamation,
              color: Colors.amber.shade600,
              size: 30.w,
            ),
            title: Text(
              "Upload a clear X-ray image without blur or strong light less than 10 MB.",
              style: Styles.textStyleInter16.copyWith(
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSelectedImageTile() {
    if (_selectedImage == null) return const SizedBox.shrink();

    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.file(
          _selectedImage!,
          height: 40.h,
          width: 40.w,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(
        _selectedImage!.path.split('/').last,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: IconButton(
        icon: SvgPicture.asset(
          'assets/icon/trash.svg',
          color: Colors.red,
        ),
        onPressed: _removeSelectedImage,
      ),
    );
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
<<<<<<< HEAD
              child: _buildImagePreview(),
            ),
            _buildWarningBanner(),
=======
              child: buildImagePreview(
                selectedImage: _selectedImage,
                navigateToEditImage: _navigateToEditImage,
              ),
            ),
            buildWarningBanner(
              selectedImage: _selectedImage,
              context: context,
            ),
>>>>>>> Scan
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
<<<<<<< HEAD
              label: Text(
=======
              child: Text(
>>>>>>> Scan
                "Upload from device",
                style: Styles.textStyleInter16.copyWith(color: kSecondaryColor),
              ),
            ),
<<<<<<< HEAD
            _buildSelectedImageTile(),
            const TextWithDividers(
              text: 'If you finished, click recognize button',
            ),
            // في الـ Widget
=======
            buildSelectedImageTile(
              selectedImage: _selectedImage,
              removeSelectedImage: _removeSelectedImage,
            ),
            const TextWithDividers(
              text: 'If you finished click recognize button',
            ),
>>>>>>> Scan
            BlocConsumer<ScanCubit, ScanState>(
              listener: (context, state) {
                if (state is ScanFailure) {
                  _showErrorSnackBar(state.errMessage);
                } else if (state is ScanSuccess &&
                    state.modelResponse != null) {
                  _handleScanResponse(state.modelResponse!);
                }
              },
              builder: (context, state) {
                final bool isDisabled =
                    _selectedImage == null || state is ScanProccessing;
                return CustomElevatedButton(
                  isLoading: state is ScanProccessing,
                  text: "Recognize",
<<<<<<< HEAD
                  onPressed: isDisabled
                      ? () {} // Empty function instead of null
                      : () => context
                          .read<ScanCubit>()
                          .processImage(_selectedImage!),
=======
                  onPressed: () async {
                    if (!isDisabled) {
                      _validateAndProcessImage();
                    } else {
                      _showErrorSnackBar("Please select an image first.");
                    }
                  },
>>>>>>> Scan
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
