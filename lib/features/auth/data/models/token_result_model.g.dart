// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenResultModel _$TokenResultModelFromJson(Map<String, dynamic> json) =>
    TokenResultModel(
      token: json['token'] as String,
      refreshTokenExpiration: json['refreshTokenExpiration'] as String,
    );

Map<String, dynamic> _$TokenResultModelToJson(TokenResultModel instance) =>
    <String, dynamic>{
      'token': instance.token,
      'refreshTokenExpiration': instance.refreshTokenExpiration,
    };
