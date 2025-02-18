// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthResponse _$AuthResponseFromJson(Map<String, dynamic> json) => AuthResponse(
      statusCode: (json['statusCode'] as num).toInt(),
      isSuccess: json['isSuccess'] as bool,
      errors: json['errors'] as List<dynamic>,
      result: TokenResultModel.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AuthResponseToJson(AuthResponse instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'isSuccess': instance.isSuccess,
      'errors': instance.errors,
      'result': instance.result,
    };
