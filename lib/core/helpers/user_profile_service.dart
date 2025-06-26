import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lungora/features/Settings/data/view_model/settings_cubit/settings_cubit.dart';
import 'package:lungora/features/auth/services/secure_storage_service.dart';

class ProfileImageService {
  static const String _defaultImage =
      'https://res.cloudinary.com/deoayl2hl/image/upload/v1742340954/Users/f446ff10-d23b-42ed-bb90-be18f88d9f01_2025_03_19_profile_avatar_brm2oi.jpg';

  static String? _cachedImageUrl;
  static bool _isLoading = false;

  static Future<String> getProfileImage(BuildContext context) async {
    if (_cachedImageUrl != null && _cachedImageUrl!.isNotEmpty) {
      return _cachedImageUrl!;
    }
    String? cachedImage = await SecureStorageService.getUserImage();
    if (cachedImage != null && cachedImage.isNotEmpty) {
      _cachedImageUrl = cachedImage;
      return cachedImage;
    }

    return await _fetchFromAPI(context);
  }

  static Future<String> _fetchFromAPI(BuildContext context) async {
    if (_isLoading) return _defaultImage;

    _isLoading = true;

    try {
      String? token = await SecureStorageService.getToken();
      if (token == null) return _defaultImage;

      SettingsCubit settingsCubit = BlocProvider.of<SettingsCubit>(context);

      // استخدام StreamSubscription مع Completer
      StreamSubscription<SettingsState>? subscription;
      Completer<String> completer = Completer<String>();

      subscription = settingsCubit.stream.listen((state) {
        if (state is SettingsGetUserDataSuccess) {
          String imageUrl = state.userModel.imageUser;

          // حفظ في الكاش
          _cachedImageUrl = imageUrl;
          SecureStorageService.saveUserImage(imageUrl);

          log("Profile image fetched and cached: $imageUrl");

          subscription?.cancel();
          if (!completer.isCompleted) {
            completer.complete(imageUrl);
          }
        } else if (state is SettingsFailure) {
          log("Failed to get user data: ${state.errMessage}");
          subscription?.cancel();
          if (!completer.isCompleted) {
            completer.complete(_defaultImage);
          }
        }
      });

      // إرسال الطلب
      settingsCubit.getUserData(token: token);

      // انتظار النتيجة مع timeout
      return await completer.future.timeout(
        const Duration(seconds: 8),
        onTimeout: () {
          subscription?.cancel();
          log("Timeout while fetching profile image");
          return _defaultImage;
        },
      );
    } catch (e) {
      log("Error fetching profile image: $e");
      return _defaultImage;
    } finally {
      _isLoading = false;
    }
  }

  // تحديث الصورة
  static void updateProfileImage(String newImageUrl) {
    _cachedImageUrl = newImageUrl;
    SecureStorageService.saveUserImage(newImageUrl);
  }

  // مسح الكاش
  static void clearCache() {
    _cachedImageUrl = null;
  }

  // الحصول على الصورة الافتراضية
  static String get defaultImage => _defaultImage;

  // التحقق من وجود صورة في الكاش
  static bool get hasCachedImage =>
      _cachedImageUrl != null && _cachedImageUrl!.isNotEmpty;
}
