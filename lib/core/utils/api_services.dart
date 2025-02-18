import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:lungora/features/Auth/data/models/auth_response_model.dart';
import 'package:retrofit/retrofit.dart';
part 'api_services.g.dart';

@RestApi(baseUrl: "https://lungora.runasp.net/")
abstract class ApiServices {
  factory ApiServices(Dio dio) = _ApiServices;
  @POST("api/Auth/login")
  Future<AuthResponse> loginUser(@Body() Map<String, dynamic> body);
  @POST("api/Auth/Register")
  Future<AuthResponse> registerUser(@Body() Map<String, dynamic> body);
}
