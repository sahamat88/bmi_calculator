import 'package:flutter/material.dart';
import '../utils/bmi_utils.dart';

class WeightInput extends StatelessWidget {
  final TextEditingController controller;
  final WeightType unit;
  final Function(WeightType) onChanged;

  const WeightInput({
    super.key,
    required this.controller,
    required this.unit,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Weight",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: controller,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  labelText: "Enter Weight",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 12),
            SegmentedButton<WeightType>(
              segments: const [
                ButtonSegment(value: WeightType.kg, label: Text("KG")),
                ButtonSegment(value: WeightType.lb, label: Text("LB")),
              ],
              selected: {unit},
              onSelectionChanged: (val) => onChanged(val.first),
            ),
          ],
        ),
      ],
    );
  }
}
