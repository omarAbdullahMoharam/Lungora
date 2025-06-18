import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lungora/core/utils/app_router.dart';
import 'package:lungora/features/diseases/presentation/widgets/category_details_view_body.dart';

class CategoryDetailsView extends StatelessWidget {
  final String categoryName;

  const CategoryDetailsView({
    super.key,
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            context.go(AppRouter.kHomeView);
          },
        ),
      ),
      body: CategoryDetailsViewBody(
        categoryName: categoryName,
      ),
    );
  }
}
