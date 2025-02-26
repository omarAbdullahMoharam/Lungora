// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthResponse _$AuthResponseFromJson(Map<String, dynamic> json) => AuthResponse(
      statusCode: (json['statusCode'] as num).toInt(),
      isSuccess: json['isSuccess'] as bool,
      errors:
          (json['errors'] as List<dynamic>?)?.map((e) => e as String).toList(),
      message: json['message'] as String?,
      result: json['result'] == null
          ? null
          : ResultModel.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AuthResponseToJson(AuthResponse instance) =>
    <String, dynamic>{
      'isSuccess': instance.isSuccess,
      'statusCode': instance.statusCode,
      'errors': instance.errors,
      'message': instance.message,
      'result': instance.result,
    };
