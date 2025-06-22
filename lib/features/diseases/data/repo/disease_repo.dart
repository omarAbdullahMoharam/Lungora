import 'package:lungora/core/helpers/api_services.dart';
import 'package:lungora/features/diseases/data/model/articles_model.dart';

class DiseaseRepo {
  final ApiServices apiServices;

  DiseaseRepo(this.apiServices);

  Future<ArticlesModel> getArticles() async {
    final categories = await apiServices.getAllCategoriesRaw();
    return categories;
  }
  // Future<CategoryModel> getCategoryById(int id) async {
  //   final category = await apiServices.getCategoryById(id);
  //   return category;
  // }
}
