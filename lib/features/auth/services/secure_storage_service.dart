import 'dart:convert';
import 'dart:developer';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static const _secureStorage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  // Storage Keys
  static const _tokenKey = "auth_token";
  static const _refreshTokenKey = "refresh_token";
  static const _tokenExpiryKey = "token_expiry";
  static const _refreshTokenExpiryKey = "refresh_token_expiry";
  static const _dataKey = "auth_data";
  static const _userNameKey = "user_name";
  static const _userImageKey = "user_image";

  // ─────── Token Methods ───────

  static Future<void> saveToken(String token) async {
    try {
      await _secureStorage.write(key: _tokenKey, value: token);
    } catch (e) {
      log('Error saving token: $e');
    }
  }

  static Future<String?> getToken() async {
    return _secureStorage.read(key: _tokenKey);
  }

  static Future<void> deleteToken() async {
    await _secureStorage.delete(key: _tokenKey);
  }

  static Future<void> saveRefreshToken(String refreshToken) async {
    await _secureStorage.write(key: _refreshTokenKey, value: refreshToken);
  }

  static Future<String?> getRefreshToken() async {
    return _secureStorage.read(key: _refreshTokenKey);
  }

  static Future<void> saveTokenExpiry(DateTime expiryTime) async {
    await _secureStorage.write(
      key: _tokenExpiryKey,
      value: expiryTime.millisecondsSinceEpoch.toString(),
    );
  }

  static Future<bool> isTokenExpired() async {
    final expiryString = await _secureStorage.read(key: _tokenExpiryKey);
    if (expiryString == null) return true;

    final expiryTime =
        DateTime.fromMillisecondsSinceEpoch(int.parse(expiryString));
    return DateTime.now().isAfter(expiryTime);
  }

  static Future<bool> isTokenValid() async {
    final token = await getToken();
    if (token == null) return false;
    return !(await isTokenExpired());
  }

  // ─────── User Info ───────

  static Future<void> saveUserName(String name) async {
    await _secureStorage.write(key: _userNameKey, value: name);
  }

  static Future<String?> getUserName() async {
    return _secureStorage.read(key: _userNameKey);
  }

  static Future<void> saveUserImage(String? imageUrl) async {
    try {
      if (imageUrl != null && imageUrl.isNotEmpty) {
        await _secureStorage.write(key: _userImageKey, value: imageUrl);
        log('User image saved: $imageUrl');
      } else {
        // إذا كانت null أو فارغة، احذف المفتاح
        await _secureStorage.delete(key: _userImageKey);
        log('User image cleared from storage');
      }
    } catch (e) {
      log('Error saving user image: $e');
    }
  }

  static Future<String?> getUserImage() async {
    try {
      return await _secureStorage.read(key: _userImageKey);
    } catch (e) {
      log('Error getting user image: $e');
      return null;
    }
  }

// method إضافية للتحقق من وجود صورة
  static Future<bool> hasUserImage() async {
    try {
      String? image = await getUserImage();
      return image != null && image.isNotEmpty;
    } catch (e) {
      log('Error checking user image: $e');
      return false;
    }
  }

// method لحذف صورة المستخدم فقط
  static Future<void> deleteUserImage() async {
    try {
      await _secureStorage.delete(key: _userImageKey);
      log('User image deleted');
    } catch (e) {
      log('Error deleting user image: $e');
    }
  }
  // ─────── General Data ───────

  static Future<void> saveData(Map<String, dynamic> data) async {
    await _secureStorage.write(key: _dataKey, value: json.encode(data));
  }

  static Future<Map<String, dynamic>?> getData() async {
    final dataJson = await _secureStorage.read(key: _dataKey);
    if (dataJson == null) return null;
    return json.decode(dataJson) as Map<String, dynamic>;
  }

  static Future<Map<String, dynamic>?> getDataFromToken() async {
    final token = await getToken();
    if (token == null) return null;
    return getData();
  }

  static Future<void> deleteData() async {
    await _secureStorage.delete(key: _dataKey);
  }

  // ─────── Clear All ───────

  static Future<void> deleteAll() async {
    await _secureStorage.deleteAll();
  }

  // ─────── Login/Register Responses ───────

  static Future<void> saveLoginResponse(
      Map<String, dynamic> loginResponse) async {
    await _handleAuthResponse(loginResponse);
  }

  static Future<void> saveRegisterResponse(
      Map<String, dynamic> registerResponse) async {
    await _handleAuthResponse(registerResponse);
  }

  static Future<Map<String, dynamic>?> getLoginResponse() async => getData();
  static Future<Map<String, dynamic>?> getRegisterResponse() async => getData();

  // ─────── JWT Decode Helper ───────

  static Map<String, dynamic> _decodeJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('Invalid JWT token');
    }
    final payload = parts[1];
    final normalized = base64Url.normalize(payload);
    final decoded = utf8.decode(base64Url.decode(normalized));
    return json.decode(decoded);
  }

  // ─────── Shared Auth Handler ───────

  static Future<void> _handleAuthResponse(Map<String, dynamic> response) async {
    final result = response['result'];
    final token = result?['token'];
    final refreshToken = result?['refreshToken'];
    final refreshExpiry = result?['refreshTokenExpiration'];

    if (token != null) {
      await saveToken(token);

      try {
        final decodedToken = _decodeJwt(token);
        if (decodedToken.containsKey('exp')) {
          final expiry =
              DateTime.fromMillisecondsSinceEpoch(decodedToken['exp'] * 1000);
          await saveTokenExpiry(expiry);
        }
      } catch (e) {
        log('JWT decode error: $e');
      }
    }

    if (refreshToken != null) {
      await saveRefreshToken(refreshToken);
    }

    if (refreshExpiry != null && refreshExpiry != "0001-01-01T00:00:00") {
      await _secureStorage.write(
          key: _refreshTokenExpiryKey, value: refreshExpiry);
    }

    await saveData(response);
  }
}
