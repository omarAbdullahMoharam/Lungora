import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lungora/core/helpers/user_profile_service.dart';

class ProfileImageButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final double? size;
  final bool showLoadingIndicator;

  const ProfileImageButton({
    super.key,
    this.onPressed,
    this.size,
    this.showLoadingIndicator = true,
  });

  @override
  State<ProfileImageButton> createState() => _ProfileImageButtonState();
}

class _ProfileImageButtonState extends State<ProfileImageButton> {
  String? _currentImagePath;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
  }

  Future<void> _loadProfileImage() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      String imageUrl = await ProfileImageService.getProfileImage(context);
      if (mounted) {
        setState(() {
          _currentImagePath = imageUrl;
        });
      }
    } catch (e) {
      log('Error loading profile image: $e');
      if (mounted) {
        setState(() {
          _currentImagePath = ProfileImageService.defaultImage;
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // إعادة تحميل الصورة (للتحديث)
  Future<void> refreshImage() async {
    ProfileImageService.clearCache();
    await _loadProfileImage();
  }

  @override
  Widget build(BuildContext context) {
    double size = widget.size ?? 42.w;

    return IconButton(
      padding: EdgeInsets.zero,
      onPressed: widget.onPressed,
      icon: SizedBox(
        height: size,
        width: size,
        child: ClipRRect(
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(size / 2),
          child: _isLoading && widget.showLoadingIndicator
              ? _buildLoadingIndicator()
              : _buildProfileImage(),
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Container(
      color: Colors.grey[200],
      child: const Center(
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
    );
  }

  Widget _buildProfileImage() {
    if (_currentImagePath == null) {
      return Container(
        color: Colors.grey[200],
        child: const Icon(Icons.person, color: Colors.grey),
      );
    }

    return Image(
      image: _currentImagePath!.startsWith('http')
          ? NetworkImage(_currentImagePath!)
          : FileImage(File(_currentImagePath!)) as ImageProvider,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        log('Error loading image: $error');
        return Image.network(
          ProfileImageService.defaultImage,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey[200],
              child: const Icon(Icons.person, color: Colors.grey),
            );
          },
        );
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          color: Colors.grey[200],
          child: const Center(
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        );
      },
    );
  }
}
