import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lungora/core/utils/styles.dart';
import 'package:lungora/features/diseases/data/model/category_model.dart';
import 'package:lungora/features/diseases/data/model/disease_article_model.dart';

class DiseaseCardItem extends StatelessWidget {
  final CategoryModel categoryModel;

  const DiseaseCardItem({
    super.key,
    required this.categoryModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          categoryModel.categoryName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Styles.textStyle16.copyWith(
            fontFamily: 'poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        buildArticlesList(categoryModel.articles, context),
        SizedBox(height: 16.h),
      ],
    );
  }
}

Widget buildArticlesList(
    List<DiseaseArticleModel> articles, BuildContext context) {
  return ListView.builder(
    itemCount: articles.length,
    itemBuilder: (context, index) {
      return DiseaseCardItem(
          categoryModel: CategoryModel(
        id: articles[index].id,
        categoryName: articles[index].title,
        articles: [
          DiseaseArticleModel(
            id: articles[index].id,
            title: articles[index].title,
            description: articles[index].description,
          ),
        ],
      ));
    },
  );
}
