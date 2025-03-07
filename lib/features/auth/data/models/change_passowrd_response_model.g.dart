// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_passowrd_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangePasswordResponse _$ChangePasswordResponseFromJson(
        Map<String, dynamic> json) =>
    ChangePasswordResponse(
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

Map<String, dynamic> _$ChangePasswordResponseToJson(
        ChangePasswordResponse instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'isSuccess': instance.isSuccess,
      'errors': instance.errors,
      'result': instance.result?.toJson(),
    };
