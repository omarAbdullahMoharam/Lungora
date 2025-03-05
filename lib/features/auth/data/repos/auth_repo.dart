import 'dart:developer';

import 'package:lungora/core/helpers/api_services.dart';
import 'package:lungora/features/Auth/data/models/auth_response_model.dart';
import 'package:lungora/features/auth/data/models/login_response_model.dart';
import 'package:lungora/features/auth/data/models/register_response_model.dart';

class AuthRepo {
  ApiServices apiServices;
  AuthRepo(this.apiServices);
  Future<LoginResponse> login(String email, String password) async {
    // trigger login
    return apiServices.loginUser({
      'email': email,
      'password': password,
    });
  }

  Future<RegisterResponse> register(
    String name,
    String email,
    String password,
    String confirmPassword,
  ) async {
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

  // reset
  Future<AuthResponse> resetUserPassword({
    required String email,
    required String code,
    required String newPassword,
    required String confirmPassword,
  }) async {
    log('returned email is $email \nOTP is $code and \nnew password is $newPassword and \nconfirm password is $confirmPassword \nfrom main call');
    // reset password logic
    return apiServices.resetPassword({
      "email": email,
      "code": code,
      "newPassword": newPassword,
      "confirmPassword": confirmPassword,
    });
  }

  // // change password
  // Future<void> changePassword(String oldPassword, String newPassword) async {
  //   // change password logic
  // }
}
