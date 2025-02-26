import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lungora/core/constants.dart';
import 'package:lungora/core/utils/styles.dart';
import 'package:lungora/core/utils/custom_elevated_button.dart';
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

  void _recognizeImage() {
    if (_selectedImage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Processing image...")),
      );
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
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 16.h),
            child: _selectedImage != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      _selectedImage!,
                      height: 290.h,
                      width: 240.w,
                      fit: BoxFit.fill,
                    ),
                  )
                : Container(
                    height: 290.h,
                    width: 230.w,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/images/lung_scan.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
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
            icon: Icon(Icons.upload_file, color: kSecondaryColor),
            label: Text(
              "Upload from device",
              style: Styles.textStyleInter16,
            ),
          ),
          if (_selectedImage != null)
            ListTile(
              leading: Icon(Icons.image, color: kPrimaryColor),
              title: Text(
                _selectedImage!.path.split('/').last,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
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
          CustomElevatedButton(
            text: "Recognize",
            onPressed: () => _recognizeImage(),
            backgroundColor: kPrimaryColor,
          ),
        ],
      ),
    );
  }
}
