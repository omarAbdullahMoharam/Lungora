import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:lungora/core/constants.dart';
import 'package:lungora/core/helpers/api_services.dart';
import 'package:lungora/core/utils/app_router.dart';
import 'package:lungora/core/utils/dependency_injection.dart';

import 'package:lungora/core/utils/styles.dart';
import 'package:lungora/core/utils/custom_elevated_button.dart';
import 'package:lungora/features/Scan/data/models/ai_model_response.dart';
import 'package:lungora/features/Scan/data/repos/scan_repo.dart';
import 'package:lungora/features/Scan/presentation/view_model/cubit/scan_cubit.dart';
import 'dart:io';
import 'package:lungora/features/Scan/presentation/widgets/text_with_dividers.dart';

class ScanViewBody extends StatefulWidget {
  const ScanViewBody({super.key});

  @override
  State<ScanViewBody> createState() => _ScanViewBodyState();
}

class _ScanViewBodyState extends State<ScanViewBody> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  void _recognizeImage() async {
    if (_selectedImage != null) {
      // String? token = await SecureStorageService.getToken();

      // AiModelResponse response = await ScanRepo(getIt<ApiServices>())
      //     .getAIModel(image: _selectedImage!);

      BlocProvider.of<ScanCubit>(context).processImage(_selectedImage!);
      AiModelResponse response =
          await ScanRepo(getIt<ApiServices>()).getAIModel(
        image: _selectedImage!,
      ); // Cast to ScanSuccess to access modelResponse
      // log("Image path: ${_selectedImage!.path}");
      // // log("Token: $token");
      // log("Image name: ${_selectedImage!.path.split('/').last}");
      // log("Image size: ${_selectedImage!.lengthSync()} bytes");
      // log('Image recognized successfully!');
      // log("\n\n\nResponse from scan view body : ${response.result} \n\n\n");

      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text("Processing image...")),
      // );
      if (response.statusCode == 200) {
        if (response.result!.predicted == 'Covid') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Covid-19 detected☣️🦠")),
          );
          context.go(AppRouter.kCovid19Result);
        } else if (response.result!.predicted == 'Pneumonia') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Pneumonia detected!😰")),
          );
          context.go(AppRouter.kCovid19Result);
        } else if (response.result!.predicted == 'Normal') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Normal scan!🫁🛡️")),
          );
          context.go(AppRouter.kNormalScanResult);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Undetected result!")),
          );
          context.go(AppRouter.kUnableDetermineResult);
        }
      }
      // context.go(AppRouter.kNormalScanResult);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select an image first.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<ScanCubit, ScanState>(
            builder: (context, state) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 16.h),
                child: (_selectedImage != null && state is! ScanProccessing)
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          _selectedImage!,
                          height: 290.h,
                          width: 250.w,
                          fit: BoxFit.fill,
                        ),
                      )
                    : (state is ScanProccessing && _selectedImage != null)
                        ? Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.file(
                                  _selectedImage!,
                                  height: 290.h,
                                  width: 250.w,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Positioned.fill(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: kSecondaryColor.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  // color: kSecondaryColor.withOpacity(0.5),
                                  child: Center(
                                    child: LottieBuilder.asset(
                                      'assets/animation/Animation-Proccessing.json',
                                      height: 500.h,
                                      width: 500.w,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Container(
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
                          ),
              );
            },
          ),
          CustomElevatedButton(
            text: "Take Picture",
            onPressed: () => _pickImage(ImageSource.camera),
            backgroundColor: kSecondaryColor,
          ),
          SizedBox(height: 8.h),
          OutlinedButton.icon(
            onPressed: () => _pickImage(ImageSource.gallery),
            style: OutlinedButton.styleFrom(
              minimumSize: Size(1.sw, 50.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.w),
              ),
              side: BorderSide(color: kSecondaryColor),
            ),
            // icon: Icon(Icons.upload_file, color: kSecondaryColor),
            label: Text(
              "Upload from device",
              style: Styles.textStyleInter16.copyWith(color: kSecondaryColor),
            ),
          ),
          if (_selectedImage != null)
            ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(
                  _selectedImage!,
                  height: 25.h,
                  width: 25.w,
                  fit: BoxFit.fill,
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
                  // ignore: deprecated_member_use
                  color: Colors.red,
                ),
                onPressed: () {
                  setState(() {
                    _selectedImage = null;
                  });
                },
              ),
            ),
          const TextWithDividers(
            text: 'if you finished click recognize button',
          ),
          BlocBuilder<ScanCubit, ScanState>(
            builder: (context, state) {
              return CustomElevatedButton(
                isLoading: state is ScanProccessing,
                text: "Recognize",
                onPressed: () => _recognizeImage(),
                backgroundColor: kPrimaryColor,
              );
            },
          ),
        ],
      ),
    );
  }
}
