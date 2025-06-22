import 'package:flutter/material.dart';
import 'package:lungora/features/diseases/presentation/widgets/disease_card_item.dart';

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

class AllCategoriesViewBody extends StatelessWidget {
  const AllCategoriesViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    // This is a placeholder for the actual categories list.
    // Replace with your actual categories data.

    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return DiseaseCardItem(
          diseaseName: "abc",
          diseaseDescription: "abc",
          treatmentDescription: "abc",
        );
      },
    );
  }
}
