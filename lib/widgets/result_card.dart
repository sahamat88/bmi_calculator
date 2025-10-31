import 'package:flutter/material.dart';
import '../utils/bmi_utils.dart';

class ResultCard extends StatelessWidget {
  final double bmi;
  final String category;

  const ResultCard({super.key, required this.bmi, required this.category});

  @override
  Widget build(BuildContext context) {
    final color = BMIUtils.getCategoryColor(category);

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              "Your BMI",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              bmi.toStringAsFixed(2),
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Chip(
              label: Text(
                category,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
              backgroundColor: color,
            ),
          ],
        ),
      ),
    );
  }
}
