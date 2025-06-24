class DiseaseArticleModel {
  final int id;
  final String title;
  final String description;

  DiseaseArticleModel({
    required this.id,
    required this.title,
    required this.description,
  });

  factory DiseaseArticleModel.fromJson(Map<String, dynamic> json) {
    return DiseaseArticleModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }
}
