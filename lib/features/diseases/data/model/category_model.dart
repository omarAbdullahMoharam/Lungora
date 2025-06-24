import 'package:lungora/features/diseases/data/model/disease_article_model.dart';

class CategoryModel {
  final int id;
  final String categoryName;
  final List<DiseaseArticleModel> articles;

  CategoryModel({
    required this.id,
    required this.categoryName,
    required this.articles,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      categoryName: json['categoryName'],
      articles: (json['articles'] as List)
          .map((e) => DiseaseArticleModel.fromJson(e))
          .toList(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'categoryName': categoryName,
      'articles': articles.map((e) => e.toJson()).toList(),
    };
  }
}
