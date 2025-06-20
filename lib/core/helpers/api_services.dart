import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:lungora/features/Auth/data/models/auth_response_model.dart';
import 'package:lungora/features/Scan/data/models/ai_model_response.dart';
import 'package:lungora/features/Settings/data/models/edit_info_response_model.dart';
import 'package:lungora/features/Settings/data/models/logout_response_model.dart';
import 'package:lungora/features/Settings/data/models/user_data_response_model.dart';
import 'package:lungora/features/auth/data/models/change_passowrd_response_model.dart';
import 'package:lungora/features/auth/data/models/login_response_model.dart';
import 'package:lungora/features/auth/data/models/register_response_model.dart';
import 'package:lungora/features/doctor/data/doctor_details_model.dart';
// import 'package:lungora/features/doctor/data/doctor_info_model.dart';
import 'package:lungora/features/doctor/data/doctor_model.dart';
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
  Future<EditInfoResponse> editInfo(
      @Part() FormData formData, @Header("Authorization") String token);
  @GET("api/Auth/GetDataUser")
  Future<UserDataResponseModel> getUserData(
      @Header("Authorization") String token);
  @POST("api/Auth/LogOutSingle")
  Future<LogoutResponse> logout(@Header("Authorization") String token);
  @POST("api/ModelAI/AI_Model")
  Future<AiModelResponse> getAIModel(@Part() FormData formData);
  // @GET("api/Doctor/GetAllDoctorsWithMobile")
  // Future<List<DoctorInfoModel>> getAllDoctorsWithMobile();

  @GET("api/Doctor/GetAllDoctorsWithMobile")
  Future<List<DoctorModel>> getAllDoctors({
    @Query("latitude") double? latitude,
    @Query("longitude") double? longitude,
    @Query("distance") int? distance,
  });
  @GET("api/Doctor/GetDoctorById/{id}")
  Future<DoctorDetailsModel> getDoctorDetails(@Path("id") int id);
  // @GET("api/Doctor/GetAllDoctorsByNearestLocation")
  // Future<List<DoctorModel>> getAllDoctorsByNearestLocation({
  //   @Query("latitude") required double latitude,
  //   @Query("longitude") required double longitude,
  // });
}
