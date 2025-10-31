import 'package:flutter/material.dart';

enum HeightType { cm, meter, feetInch }

enum WeightType { kg, lb }

class BMIUtils {
  // Weight conversion
  static double? getWeightInKg(String text, WeightType type) {
    final weight = double.tryParse(text.trim());
    if (weight == null || weight <= 0) return null;
    return type == WeightType.lb ? weight * 0.453592 : weight;
  }

  // Height conversion
  static double? getHeightInMeter(
    String cm,
    String m,
    String ft,
    String inch,
    HeightType type,
  ) {
    switch (type) {
      case HeightType.cm:
        final val = double.tryParse(cm.trim());
        if (val == null || val <= 0) return null;
        return val / 100.0;

      case HeightType.meter:
        final val = double.tryParse(m.trim());
        if (val == null || val <= 0) return null;
        return val;

      case HeightType.feetInch:
        double? feet = double.tryParse(ft.trim());
        double? inches = double.tryParse(inch.trim());
        if (feet == null || inches == null || feet < 0 || inches < 0) {
          return null;
        }

        // Auto carry inches → feet
        if (inches >= 12) {
          feet += (inches ~/ 12);
          inches = inches % 12;
        }

        final totalInches = (feet * 12) + inches;
        return totalInches * 0.0254;
    }
  }

  // Category
  static String getCategory(double bmi) {
    if (bmi < 18.5) return "Underweight";
    if (bmi < 25) return "Normal";
    if (bmi < 30) return "Overweight";
    return "Obese";
  }

  // Color mapping
  static Color getCategoryColor(String category) {
    switch (category) {
      case "Underweight":
        return Colors.blue;
      case "Normal":
        return Colors.green;
      case "Overweight":
        return Colors.orange;
      case "Obese":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
