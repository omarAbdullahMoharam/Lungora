import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lungora/features/diseases/data/model/disease_article_details_model.dart';

import 'package:lungora/features/diseases/presentation/widgets/disease_details_view_body.dart';

class DiseaseDetailsView extends StatelessWidget {
  final String diseaseName;
  final String diseaseDescription;
  final String treatmentMethods;
  final DiseaseArticleDetailsModel? diseaseArticleDetailsModel;

  const DiseaseDetailsView({
    super.key,
    required this.diseaseName,
    required this.diseaseDescription,
    required this.treatmentMethods,
    this.diseaseArticleDetailsModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: DiseaseDetailsViewBody(
        diseaseImageUrl: diseaseArticleDetailsModel?.coverImage,
        diseaseName: diseaseArticleDetailsModel != null
            ? diseaseArticleDetailsModel!.title
            : diseaseName,
        diseaseDescription: diseaseArticleDetailsModel != null
            ? diseaseArticleDetailsModel!.description
            : diseaseDescription,
        treatmentMethods: diseaseArticleDetailsModel != null
            ? diseaseArticleDetailsModel!.content
            : treatmentMethods,
      ),
    );
  }
}
