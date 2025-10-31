import 'package:flutter/material.dart';
import '../utils/bmi_utils.dart';

class HeightInput extends StatelessWidget {
  final TextEditingController cmController;
  final TextEditingController meterCtr;
  final TextEditingController feetCtr;
  final TextEditingController inchCtr;
  final HeightType unit;
  final Function(HeightType) onChanged;

  const HeightInput({
    super.key,
    required this.cmController,
    required this.meterCtr,
    required this.feetCtr,
    required this.inchCtr,
    required this.unit,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Height",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        SegmentedButton<HeightType>(
          segments: const [
            ButtonSegment(value: HeightType.cm, label: Text("CM")),
            ButtonSegment(value: HeightType.meter, label: Text("M")),
            ButtonSegment(value: HeightType.feetInch, label: Text("Ft + In")),
          ],
          selected: {unit},
          onSelectionChanged: (val) => onChanged(val.first),
        ),
        const SizedBox(height: 12),
        if (unit == HeightType.cm)
          TextFormField(
            controller: cmController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              labelText: "Height (cm)",
              border: OutlineInputBorder(),
            ),
          )
        else if (unit == HeightType.meter)
          TextFormField(
            controller: meterCtr,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              labelText: "Height (m)",
              border: OutlineInputBorder(),
            ),
          )
        else
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: feetCtr,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: const InputDecoration(
                    labelText: "Feet (ft)",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextFormField(
                  controller: inchCtr,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: const InputDecoration(
                    labelText: "Inches (in)",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
