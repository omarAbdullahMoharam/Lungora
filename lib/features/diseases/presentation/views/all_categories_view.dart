import 'package:flutter/material.dart';
import 'package:lungora/features/diseases/presentation/widgets/all_categories_view_body.dart';

class AllCategoriesView extends StatelessWidget {
  const AllCategoriesView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Categories'),
      ),
      body: AllCategoriesViewBody(),
    );
  }
}
