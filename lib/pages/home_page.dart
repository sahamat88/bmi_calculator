import 'package:flutter/material.dart';
import '../utils/bmi_utils.dart';
import '../widgets/weight_input.dart';
import '../widgets/height_input.dart';
import '../widgets/result_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HeightType heightType = HeightType.cm;
  WeightType weightType = WeightType.kg;

  final weightController = TextEditingController();
  final cmController = TextEditingController();
  final meterController = TextEditingController();
  final feetController = TextEditingController();
  final inchController = TextEditingController();

  double? bmi;
  String? category;

  void calculateBMI() {
    final weightKg = BMIUtils.getWeightInKg(weightController.text, weightType);
    final heightM = BMIUtils.getHeightInMeter(
      cmController.text,
      meterController.text,
      feetController.text,
      inchController.text,
      heightType,
    );

    if (weightKg == null || heightM == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter valid positive values!")),
      );
      return;
    }

    final result = weightKg / (heightM * heightM);
    setState(() {
      bmi = result;
      category = BMIUtils.getCategory(result);
    });
  }

  @override
  void dispose() {
    weightController.dispose();
    cmController.dispose();
    meterController.dispose();
    feetController.dispose();
    inchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BMI Calculator"),
        backgroundColor: Colors.blueAccent,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black54, Colors.transparent],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            WeightInput(
              controller: weightController,
              unit: weightType,
              onChanged: (val) => setState(() => weightType = val),
            ),
            const SizedBox(height: 20),
            HeightInput(
              cmCtr: cmController,
              meterCtr: meterController,
              feetCtr: feetController,
              inchCtr: inchController,
              unit: heightType,
              onChanged: (val) => setState(() => heightType = val),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: calculateBMI,
              child: const Text("Calculate BMI"),
            ),
            const SizedBox(height: 24),
            if (bmi != null && category != null)
              ResultCard(bmi: bmi!, category: category!),
          ],
        ),
      ),
    );
  }
}
