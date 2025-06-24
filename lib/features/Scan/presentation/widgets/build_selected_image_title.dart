import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

Widget buildSelectedImageTile(
    {required File? selectedImage, required VoidCallback removeSelectedImage}) {
  if (selectedImage == null) return const SizedBox.shrink();

  return ListTile(
    leading: ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.file(
        selectedImage,
        height: 40.h,
        width: 40.w,
        fit: BoxFit.cover,
      ),
    ),
    title: Text(
      selectedImage.path.split('/').last,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    ),
    trailing: IconButton(
      icon: SvgPicture.asset(
        'assets/icon/trash.svg',
        color: Colors.red,
      ),
      onPressed: removeSelectedImage,
    ),
  );
}
