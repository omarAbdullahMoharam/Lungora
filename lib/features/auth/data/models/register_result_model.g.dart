// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterResultModel _$RegisterResultModelFromJson(Map<String, dynamic> json) =>
    RegisterResultModel(
      token: json['token'] as String?,
      refreshTokenExpiration: json['refreshTokenExpiration'] as String?,
    );

Map<String, dynamic> _$RegisterResultModelToJson(
        RegisterResultModel instance) =>
    <String, dynamic>{
      'token': instance.token,
      'refreshTokenExpiration': instance.refreshTokenExpiration,
    };
