import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:lungora/features/Auth/data/models/auth_response_model.dart';
import 'package:lungora/features/auth/data/models/login_response_model.dart';
import 'package:lungora/features/auth/data/models/register_response_model.dart';
import 'package:retrofit/retrofit.dart';
part 'api_services.g.dart';

@RestApi(baseUrl: "https://lungora.runasp.net/")
abstract class ApiServices {
  factory ApiServices(Dio dio) = _ApiServices;
  @POST("api/Auth/login")
  Future<LoginResponse> loginUser(@Body() Map<String, dynamic> body);
  @POST("api/Auth/Register")
  Future<RegisterResponse> registerUser(@Body() Map<String, dynamic> body);
  @POST("api/Auth/ForgotPassword")
  Future<AuthResponse> forgotPassword(@Body() Map<String, dynamic> body);
  @POST("api/Auth/VerifyResetCode")
  Future<AuthResponse> verifyOTP(@Body() Map<String, dynamic> body);
  @POST("api/Auth/ResetPassword")
  Future<AuthResponse> resetPassword(@Body() Map<String, dynamic> body);

  // add more endpoints here @amera612
}
