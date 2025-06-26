import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lungora/features/Settings/data/view_model/settings_cubit/settings_cubit.dart';
import 'package:lungora/features/auth/services/secure_storage_service.dart';

class ProfileNameService {
  static const String _defaultName = 'User';

  static String? _cachedName;
  static bool _isLoading = false;

  /// الحصول على اسم المستخدم من الكاش أو من الـ API
  static Future<String> getProfileName(BuildContext context) async {
    // التحقق من وجود الاسم في الكاش المؤقت
    if (_cachedName != null && _cachedName!.isNotEmpty) {
      return _cachedName!;
    }

    // التحقق من وجود الاسم في التخزين المحلي
    String? cachedName = await SecureStorageService.getUserName();
    if (cachedName != null && cachedName.isNotEmpty) {
      _cachedName = cachedName;
      return cachedName;
    }

    // إذا لم يكن موجود، جلب من الـ API
    return await _fetchFromAPI(context);
  }

  /// جلب الاسم من الـ API
  static Future<String> _fetchFromAPI(BuildContext context) async {
    if (_isLoading) return _defaultName;

    _isLoading = true;

    try {
      String? token = await SecureStorageService.getToken();
      if (token == null) return _defaultName;

      SettingsCubit settingsCubit = BlocProvider.of<SettingsCubit>(context);

      // استخدام StreamSubscription مع Completer
      StreamSubscription<SettingsState>? subscription;
      Completer<String> completer = Completer<String>();

      subscription = settingsCubit.stream.listen((state) {
        if (state is SettingsGetUserDataSuccess) {
          String userName = state.userModel.fullName;

          // حفظ في الكاش
          _cachedName = userName;
          SecureStorageService.saveUserName(userName);

          log("Profile name fetched and cached: $userName");

          subscription?.cancel();
          if (!completer.isCompleted) {
            completer.complete(userName);
          }
        } else if (state is SettingsFailure) {
          log("Failed to get user data: ${state.errMessage}");
          subscription?.cancel();
          if (!completer.isCompleted) {
            completer.complete(_defaultName);
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
          log("Timeout while fetching profile name");
          return _defaultName;
        },
      );
    } catch (e) {
      log("Error fetching profile name: $e");
      return _defaultName;
    } finally {
      _isLoading = false;
    }
  }

  /// تحديث اسم المستخدم
  static void updateProfileName(String newName) {
    _cachedName = newName;
    SecureStorageService.saveUserName(newName);
    log("Profile name updated: $newName");
  }

  /// مسح الكاش
  static void clearCache() {
    _cachedName = null;
    log("Profile name cache cleared");
  }

  /// الحصول على الاسم الافتراضي
  static String get defaultName => _defaultName;

  /// التحقق من وجود اسم في الكاش
  static bool get hasCachedName =>
      _cachedName != null && _cachedName!.isNotEmpty;

  /// الحصول على الاسم من الكاش فقط (بدون API call)
  static Future<String?> getCachedNameOnly() async {
    if (_cachedName != null && _cachedName!.isNotEmpty) {
      return _cachedName;
    }
    return await SecureStorageService.getUserName();
  }

  /// التحقق من صحة الاسم
  static bool isValidName(String? name) {
    return name != null &&
        name.trim().isNotEmpty &&
        name.trim() != _defaultName;
  }

  /// إعادة تعيين الاسم للقيمة الافتراضية
  static void resetToDefault() {
    _cachedName = _defaultName;
    SecureStorageService.saveUserName(_defaultName);
    log("Profile name reset to default");
  }
}
