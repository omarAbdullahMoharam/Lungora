class DiseaseArticleDetailsModel {
  final String title;
  final String description;
  final String content;
  final String coverImage;

  DiseaseArticleDetailsModel({
    required this.title,
    required this.description,
    required this.content,
    required this.coverImage,
  });

  factory DiseaseArticleDetailsModel.fromJson(Map<String, dynamic> json) {
    return DiseaseArticleDetailsModel(
      title: json['result']['title'],
      description: json['result']['description'],
      content: json['result']['content'],
      coverImage: json['result']['coverImage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'result': {
        'title': title,
        'description': description,
        'content': content,
        'coverImage': coverImage,
      }
    };
  }
}
