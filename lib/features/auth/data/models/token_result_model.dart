import 'package:json_annotation/json_annotation.dart';

part 'token_result_model.g.dart';

@JsonSerializable()
class TokenResultModel {
  final String token;
  final String refreshTokenExpiration;

  TokenResultModel({
    required this.token,
    required this.refreshTokenExpiration,
  });

  factory TokenResultModel.fromJson(Map<String, dynamic> json) =>
      _$TokenResultModelFromJson(json);
  Map<String, dynamic> toJson() => _$TokenResultModelToJson(this);
}
