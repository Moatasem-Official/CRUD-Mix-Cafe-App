import 'package:flutter/material.dart';

class OrderPreparationTime extends StatelessWidget {
  const OrderPreparationTime({
    super.key,
    this.estimatedDuration,
    this.onTimePicked,
  });

  final TimeOfDay? estimatedDuration;
  final Function(TimeOfDay picked)? onTimePicked;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      decoration: InputDecoration(
        labelText: "Estimated Preparation Time",
        labelStyle: const TextStyle(color: Color(0xFF8B4513)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        prefixIcon: const Icon(Icons.timer, color: Color(0xFF8B4513)),
        filled: true,
        fillColor: const Color(0xFFFDF9F6),
      ),
      controller: TextEditingController(
        text: estimatedDuration != null
            ? "${estimatedDuration!.hour}h ${estimatedDuration!.minute}m"
            : "",
      ),
      onTap: () async {
        TimeOfDay? picked = await showTimePicker(
          context: context,
          initialTime: const TimeOfDay(hour: 0, minute: 30),
        );
        if (picked != null) {
          onTimePicked!(picked);
        }
      },
    );
  }
}
