import 'package:json_annotation/json_annotation.dart';
part 'result_model.g.dart';

@JsonSerializable()
class ResultModel {
  String? message;
  String? expire;

  ResultModel({this.message, this.expire});

  Map<String, dynamic> toJson() => _$ResultModelToJson(this);
  factory ResultModel.fromJson(Map<String, dynamic> json) =>
      _$ResultModelFromJson(json);
}
