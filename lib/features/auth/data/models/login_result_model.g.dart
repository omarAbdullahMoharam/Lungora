// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResultModel _$LoginResultModelFromJson(Map<String, dynamic> json) =>
    LoginResultModel(
      token: json['token'] as String?,
      refreshTokenExpiration: json['refreshTokenExpiration'] as String?,
    );

Map<String, dynamic> _$LoginResultModelToJson(LoginResultModel instance) =>
    <String, dynamic>{
      'token': instance.token,
      'refreshTokenExpiration': instance.refreshTokenExpiration,
    };
