import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lungora/features/Scan/presentation/view_model/cubit/scan_cubit.dart';
import 'package:lungora/features/Scan/presentation/widgets/build_placeholder_image.dart';
import 'package:lungora/features/Scan/presentation/widgets/build_processing_image.dart';
import 'package:lungora/features/Scan/presentation/widgets/editable_image_preview.dart';

Widget buildImagePreview({
  File? selectedImage,
  void Function()? navigateToEditImage,
}) {
  return BlocBuilder<ScanCubit, ScanState>(
    builder: (context, state) {
      if (selectedImage == null) {
        return buildPlaceholderImage();
      }

      if (state is ScanProccessing) {
        return buildProcessingImage(
          selectedImage: selectedImage,
        );
      }
      return EditableImagePreview(
        selectedImage: selectedImage,
        onEditTap: navigateToEditImage,
      );
    },
  );
}
