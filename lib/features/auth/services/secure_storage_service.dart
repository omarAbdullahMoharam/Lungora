import 'dart:convert';
import 'dart:developer';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );
  static const _tokenKey = "auth_token";
  static const _dataKey = "auth_data";
  static const _refreshTokenKey = "refresh_token";
  static const _tokenExpiryKey = "token_expiry";
  static const _userNameKey = "user_name";
static const _userImageKey = "user_image";

// Save user name
static Future<void> saveUserName(String name) async {
  await _secureStorage.write(key: _userNameKey, value: name);
}

// Get user name
static Future<String?> getUserName() async {
  return await _secureStorage.read(key: _userNameKey);
}

// Save user image
static Future<void> saveUserImage(String imageUrl) async {
  await _secureStorage.write(key: _userImageKey, value: imageUrl);
}

// Get user image
static Future<String?> getUserImage() async {
  return await _secureStorage.read(key: _userImageKey);
}


  static Future<void> saveToken(String token) async {
    try {
      await _secureStorage.write(key: _tokenKey, value: token);
    } catch (e) {
      log('Error from secure_storage_service while saving token: $e');
    }
  }

  static Future<String?> getToken() async {
    return await _secureStorage.read(key: _tokenKey);
  }

  // Store refresh token
  static Future<void> saveRefreshToken(String refreshToken) async {
    await _secureStorage.write(key: _refreshTokenKey, value: refreshToken);
  }

  // Get refresh token
  static Future<String?> getRefreshToken() async {
    return await _secureStorage.read(key: _refreshTokenKey);
  }

  // Store token expiry time
  static Future<void> saveTokenExpiry(DateTime expiryTime) async {
    await _secureStorage.write(
      key: _tokenExpiryKey,
      value: expiryTime.millisecondsSinceEpoch.toString(),
    );
  }

  // Check if token is expired
  static Future<bool> isTokenExpired() async {
    final expiryString = await _secureStorage.read(key: _tokenExpiryKey);
    if (expiryString == null) return true;

    final expiryTime =
        DateTime.fromMillisecondsSinceEpoch(int.parse(expiryString));
    return DateTime.now().isAfter(expiryTime);
  }

  static Future<void> saveData(Map<String, dynamic> data) async {
    await _secureStorage.write(
      key: _dataKey,
      value: json.encode(data),
    );
  }

  static Future<Map<String, dynamic>?> getData() async {
    final dataJson = await _secureStorage.read(key: _dataKey);
    if (dataJson == null) return null;
    return json.decode(dataJson) as Map<String, dynamic>;
  }

  static Future<void> deleteAll() async {
    await _secureStorage.deleteAll();
  }

  static Future<void> deleteToken() async {
    await _secureStorage.delete(key: _tokenKey);
  }

  static Future<void> deleteData() async {
    await _secureStorage.delete(key: _dataKey);
  }

  // Enhanced token validation - checks both existence and expiration
  static Future<bool> isTokenValid() async {
    final token = await getToken();
    if (token == null) return false;

    // If you're tracking expiration, check that too
    final isExpired = await isTokenExpired();
    return !isExpired;
  }

  static Future<Map<String, dynamic>?> getDataFromToken() async {
    final token = await getToken();
    if (token == null) return null;
    return await getData();
  }

  // Convenience method to initialize storage with login response
  static Future<void> saveLoginResponse(
      Map<String, dynamic> loginResponse) async {
    // Extract token
    final token = loginResponse['result']?['token'];
    if (token != null) {
      await saveToken(token);

      // Extract expiration directly from JWT token
      try {
        final decodedToken = _decodeJwt(token);
        if (decodedToken.containsKey('exp')) {
          // JWT exp is in seconds since epoch
          final expiryDateTime =
              DateTime.fromMillisecondsSinceEpoch(decodedToken['exp'] * 1000);
          await saveTokenExpiry(expiryDateTime);
        }
      } catch (e) {
        // Handle JWT decoding error
        log('Error decoding JWT: $e');
      }
    }

    // Save refresh token expiration if available
    final refreshTokenExpiration =
        loginResponse['result']?['refreshTokenExpiration'];
    if (refreshTokenExpiration != null) {
      await _secureStorage.write(
          key: "refresh_token_expiry", value: refreshTokenExpiration);
    }

    // Save full response data
    await saveData(loginResponse);
  }

  static Future<Map<String, dynamic>?> getLoginResponse() async {
    final token = await getToken();
    if (token == null) return null;
    return await getData();
  }

  static Future<void> saveRegisterResponse(
      Map<String, dynamic> registerResponse) async {
    // Extract token
    final token = registerResponse['result']?['token'];
    if (token != null) {
      await saveToken(token);

      // Extract expiration directly from JWT token
      try {
        final decodedToken = _decodeJwt(token);
        if (decodedToken.containsKey('exp')) {
          // JWT exp is in seconds since epoch
          final expiryDateTime =
              DateTime.fromMillisecondsSinceEpoch(decodedToken['exp'] * 1000);
          await saveTokenExpiry(expiryDateTime);
        }
      } catch (e) {
        // Handle JWT decoding error
        log('Error decoding JWT: $e');
      }
    }

    // Save refresh token expiration if available
    final refreshTokenExpiration =
        registerResponse['result']?['refreshTokenExpiration'];
    if (refreshTokenExpiration != null &&
        refreshTokenExpiration != "0001-01-01T00:00:00") {
      await _secureStorage.write(
          key: "refresh_token_expiry", value: refreshTokenExpiration);
    }

    // Save full response data
    await saveData(registerResponse);
  }

  static Future<Map<String, dynamic>?> getRegisterResponse() async {
    final token = await getToken();
    if (token == null) return null;
    return await getData();
  }

  static Map<String, dynamic> _decodeJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('Invalid token');
    }

    final payload = parts[1];
    final normalized = base64Url.normalize(payload);
    final resp = utf8.decode(base64Url.decode(normalized));

    return json.decode(resp);
  }
}
