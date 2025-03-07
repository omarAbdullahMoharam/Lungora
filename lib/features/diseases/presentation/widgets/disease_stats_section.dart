import 'package:flutter/material.dart';
import 'package:lungora/features/diseases/presentation/widgets/disease_stats_card.dart';

class DiseaseStatsSection extends StatelessWidget {
  const DiseaseStatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: const [
        DiseaseStatsCard(title: "Infections", value: "1974 K"),
        DiseaseStatsCard(title: "Recovered", value: "1974 K"),
        DiseaseStatsCard(title: "  Deaths  ", value: "1974 K"),
      ],
    );
  }
}
