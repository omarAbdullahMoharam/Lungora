import 'dart:developer';

import 'package:lungora/core/utils/api_services.dart';
import 'package:lungora/features/Auth/data/models/auth_response_model.dart';

class AuthRepo {
  ApiServices apiServices;
  AuthRepo(this.apiServices);
  Future<AuthResponse> login(String email, String password) async {
    // trigger login
    return apiServices.loginUser({
      'email': email,
      'password': password,
    });
  }

  Future<AuthResponse> register(String name, String email, String password,
      String confirmPassword) async {
    // trigger Register
    return apiServices.registerUser({
      'name': name,
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
    });
  }

  // Future<void> logout() async {
  //   // Logout logic

  // }
  // // forget
  Future<AuthResponse> forgetUserPassword(String email) async {
    // forget password logic
    // log(email);
    return apiServices.forgotPassword({
      "email": email,
    });
  }

  Future<AuthResponse> verifyUserOTP(
      {required String email, required String otp}) async {
    log('returned email is $email OTP is $otp from main call');
    // verify OTP logic
    return apiServices.verifyOTP({
      "email": email,
      "code": otp,
    });
  }
  // // reset
  // Future<void> resetPassword(String email, String password) async {
  //   // reset password logic
  // }

  // // update
  // Future<void> updatePassword(String oldPassword, String newPassword) async {
  //   // update password logic
  // }
}
