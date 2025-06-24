import 'package:lungora/features/diseases/data/model/category_model.dart';

class ArticlesModel {
  final int statusCode;
  final bool isSuccess;
  final List<dynamic> errors;
  final List<CategoryModel> category;

  ArticlesModel({
    required this.statusCode,
    required this.isSuccess,
    required this.errors,
    required this.category,
  });

  factory ArticlesModel.fromJson(Map<String, dynamic> json) {
    return ArticlesModel(
      statusCode: json['statusCode'],
      isSuccess: json['isSuccess'],
      errors: json['errors'],
      category: (json['result']['category'] as List)
          .map((e) => CategoryModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'isSuccess': isSuccess,
      'errors': errors,
      'result': {
        'category': category.map((e) => e.toJson()).toList(),
      }
    };
  }
}
