import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:lungora/features/Auth/data/models/auth_response_model.dart';
import 'package:lungora/features/Settings/data/repos/settings_repo.dart';
import 'package:lungora/features/Settings/data/view_model/settings_cubit/settings_cubit.dart';
import 'package:lungora/features/auth/data/models/change_passowrd_response_model.dart';
import 'package:lungora/features/auth/data/models/login_response_model.dart';
import 'package:lungora/features/auth/data/models/register_response_model.dart';
import 'package:retrofit/retrofit.dart';
part 'api_services.g.dart';

@RestApi(baseUrl: "https://lungora.runasp.net/")
abstract class ApiServices {
  factory ApiServices(Dio dio) = _ApiServices;
  @POST("api/Auth/login")
  Future<LoginResponse> login(@Body() Map<String, dynamic> body);
  @POST("api/Auth/Register")
  Future<RegisterResponse> register(@Body() Map<String, dynamic> body);
  @POST("api/Auth/ForgotPassword")
  Future<AuthResponse> forgotPassword(@Body() Map<String, dynamic> body);
  @POST("api/Auth/VerifyResetCode")
  Future<AuthResponse> verifyOTP(@Body() Map<String, dynamic> body);
  @POST("api/Auth/ResetPassword")
  Future<AuthResponse> resetPassword(@Body() Map<String, dynamic> body);
  @POST("api/Auth/ChangePassword")
  Future<ChangePasswordResponse> changePassword(
      @Body() Map<String, dynamic> body, @Header("Authorization") String token);
  @POST("api/Auth/EditInfo")
  Future<LogoutResponse> editInfo(
      @Body() Map<String, dynamic> body, @Header("Authorization") String token);

  @POST("api/Auth/LogOutSingle")
  Future<LogoutResponse> logout(@Header("Authorization") String token);
}
