import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lungora/core/utils/styles.dart';
import 'package:lungora/features/diseases/presentation/view_model/categories/categories_cubit.dart';
import 'package:lungora/features/diseases/presentation/widgets/disease_article_card.dart';
import 'package:lungora/features/diseases/presentation/widgets/empty_categories_state.dart';
import 'package:lungora/features/diseases/presentation/widgets/failure_category_state.dart';
import 'package:lungora/features/diseases/presentation/widgets/loading_categories_state.dart';

class AllCategoriesViewBody extends StatelessWidget {
  const AllCategoriesViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "All Categories",
          style: Styles.textStyle20.copyWith(
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      body: BlocBuilder<CategoriesCubit, CategoriesState>(
        builder: (context, state) {
          if (state is CategoriesLoading) {
            return LoadingCategories();
          } else if (state is CategoriesFailure) {
            return FailedCategories();
          } else if (state is CategoriesSuccess) {
            final categoriesWithArticles = state.categories
                .where((cat) => cat.articles.isNotEmpty)
                .toList();

            if (categoriesWithArticles.isEmpty) {
              return EmptyCategories();
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: categoriesWithArticles.length,
              itemBuilder: (context, index) {
                final category = categoriesWithArticles[index];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category.categoryName.trim(),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...category.articles.map(
                      (article) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: DiseaseCard(
                          article: article,
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                  ],
                );
              },
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
