import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lungora/core/utils/styles.dart';
import 'package:lungora/features/Settings/data/view_model/settings_cubit/settings_cubit.dart';
import 'package:lungora/features/auth/services/secure_storage_service.dart';

AppBar buildCustomAppBar({
  required BuildContext context,
  required Widget profileIconWidget,
}) {
  return AppBar(
    automaticallyImplyLeading: false,
    title: Padding(
      padding: EdgeInsets.only(left: 16.w),
      child: Text(
        'Lungora',
        style: Styles.textStyle20.copyWith(
          fontWeight: FontWeight.w700,
          fontFamily: 'Inter',
          height: 22.sp,
        ),
      ),
    ),
    backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
    elevation: 0,
    actions: [
      profileIconWidget,
      SizedBox(width: 16.w),
    ],
  );
}

class ProfileIconButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final String? initialImagePath;

  const ProfileIconButton({
    super.key,
    this.onPressed,
    this.initialImagePath,
  });

  @override
  State<ProfileIconButton> createState() => _ProfileIconButtonState();
}

class _ProfileIconButtonState extends State<ProfileIconButton> {
  String? _currentImagePath;
  bool _isLoading = false;
  StreamSubscription? _subscription;

  static const String _defaultImage =
      'https://res.cloudinary.com/deoayl2hl/image/upload/v1742340954/Users/f446ff10-d23b-42ed-bb90-be18f88d9f01_2025_03_19_profile_avatar_brm2oi.jpg';

  @override
  void initState() {
    super.initState();
    _currentImagePath = widget.initialImagePath;
    _loadCachedImage();
  }

  Future<void> _loadCachedImage() async {
    try {
      final cachedImage = await SecureStorageService.getUserImage();
      if (cachedImage != null && cachedImage.isNotEmpty && mounted) {
        setState(() {
          _currentImagePath = cachedImage;
        });
      }
    } catch (e) {
      log('Error loading cached image: $e');
    }
  }

  Future<void> _handleProfileImageTap() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final hasCachedImage = await SecureStorageService.hasUserImage();

      if (hasCachedImage) {
        final cachedImage = await SecureStorageService.getUserImage();
        if (cachedImage != null && mounted) {
          setState(() {
            _currentImagePath = cachedImage;
          });
          log("Using cached profile image");
        }
      } else {
        await _fetchProfileImageFromAPI();
      }

      widget.onPressed?.call();
    } catch (e) {
      log("Error in profile image handler: $e");
      widget.onPressed?.call();
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _fetchProfileImageFromAPI() async {
    try {
      final token = await SecureStorageService.getToken();
      if (token == null || !mounted) return;

      final settingsCubit = BlocProvider.of<SettingsCubit>(context);
      final completer = Completer<void>();

      _subscription = settingsCubit.stream.listen((state) {
        if (state is SettingsGetUserDataSuccess) {
          final imageUrl = state.userModel.imageUser;

          if (mounted) {
            setState(() {
              _currentImagePath = imageUrl;
            });
          }

          SecureStorageService.saveUserImage(imageUrl);
          log("Profile image fetched and cached: $imageUrl");

          _subscription?.cancel();
          if (!completer.isCompleted) completer.complete();
        } else if (state is SettingsFailure) {
          log("Failed to get user data: ${state.errMessage}");
          _subscription?.cancel();
          if (!completer.isCompleted) completer.complete();
        }
      });

      settingsCubit.getUserData(token: token);

      await completer.future.timeout(
        const Duration(seconds: 8),
        onTimeout: () {
          _subscription?.cancel();
          log("Timeout while fetching profile image");
        },
      );
    } catch (e) {
      log("Error fetching profile image: $e");
    }
  }

  ImageProvider _getImageProvider(String imagePath) {
    return imagePath.startsWith('http')
        ? NetworkImage(imagePath)
        : FileImage(File(imagePath));
  }

  @override
  Widget build(BuildContext context) {
    final finalImagePath = _currentImagePath ?? _defaultImage;

    return Stack(
      children: [
        IconButton(
          padding: EdgeInsets.zero,
          onPressed: _handleProfileImageTap,
          icon: SizedBox(
            height: 42.h,
            width: 42.w,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(60.r),
              child: Image(
                image: _getImageProvider(finalImagePath),
                fit: BoxFit.fill,
                errorBuilder: (context, error, stackTrace) {
                  log('Error loading image: $error');
                  return Image(
                    image: NetworkImage(_defaultImage),
                    fit: BoxFit.fill,
                  );
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(60.r),
                    ),
                    child: Center(
                      child: SizedBox(
                        width: 20.w,
                        height: 20.h,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        if (_isLoading)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(60.r),
              ),
              child: Center(
                child: SizedBox(
                  width: 16.w,
                  height: 16.h,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
