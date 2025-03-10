import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lungora/core/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EditProfileImage extends StatefulWidget {
  const EditProfileImage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EditProfileImageState createState() => _EditProfileImageState();
}

class _EditProfileImageState extends State<EditProfileImage> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 34.0),
      child: Stack(
        children: [
          CircleAvatar(
            radius: 80.h,
            backgroundColor: Colors.grey.shade100,
            child: _imageFile != null
                ? CircleAvatar(
                    radius: 80.r,
                    backgroundImage: FileImage(_imageFile!),
                  )
                : CircleAvatar(
                    radius: 80.r,
                    backgroundColor: Colors.grey.shade100,
                    child: SvgPicture.asset(
                      'assets/images/profile_avatar.svg',
                      fit: BoxFit.cover,
                    ),
                  ),
          ),
          Positioned(
            bottom: 0,
            right: 10,
            child: Container(
              height: 40.h,
              width: 40.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: kPrimaryColor,
              ),
              child: IconButton(
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onPressed: _pickImage,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
