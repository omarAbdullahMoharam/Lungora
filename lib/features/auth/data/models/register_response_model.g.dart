// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterResponse _$RegisterResponseFromJson(Map<String, dynamic> json) =>
    RegisterResponse(
      statusCode: (json['statusCode'] as num).toInt(),
      isSuccess: json['isSuccess'] as bool,
      errors: (json['errors'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      result: json['result'] == null
          ? null
          : RegisterResultModel.fromJson(
              json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RegisterResponseToJson(RegisterResponse instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'isSuccess': instance.isSuccess,
      'errors': instance.errors,
      'result': instance.result?.toJson(),
    };
