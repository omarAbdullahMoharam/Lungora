import 'package:lungora/core/helpers/api_services.dart';
import 'package:lungora/features/diseases/data/model/articles_model.dart';
import 'package:lungora/features/diseases/data/model/disease_article_details_model.dart';

class DiseaseRepo {
  final ApiServices apiServices;

  DiseaseRepo(this.apiServices);

  Future<ArticlesModel> getArticles() async {
    final categories = await apiServices.getAllCategoriesRaw();
    return categories;
  }

  Future<DiseaseArticleDetailsModel> getDiseaseArticleDetails(int id) async {
    final diseaseArticleDetails =
        await apiServices.getDiseaseArticleDetails(id);
    return diseaseArticleDetails;
  }
}
