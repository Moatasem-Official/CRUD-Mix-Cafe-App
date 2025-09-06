import 'package:flutter/material.dart';

class CustomTimeField extends StatelessWidget {
  const CustomTimeField({
    super.key,
    required this.controller,
    required this.label,
    required this.context,
    this.selectedTime,
    required this.onTimePicked,
  });

  final TextEditingController controller;
  final String label;
  final BuildContext context;
  final TimeOfDay? selectedTime;
  final void Function(TimeOfDay) onTimePicked;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(bottom: 16),
      child: TextFormField(
        readOnly: true,
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Color(0xFF8B4513)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          prefixIcon: const Icon(Icons.timer, color: Color(0xFF8B4513)),
          filled: true,
          fillColor: const Color(0xFFFDF9F6),
        ),
        onTap: () async {
          TimeOfDay now = TimeOfDay.now();
          TimeOfDay? picked = await showTimePicker(
            context: context,
            initialTime: selectedTime ?? now,
          );
          if (picked != null) {
            controller.text = picked.format(context);
            onTimePicked(picked);
          }
        },
      ),
    );
  }
}
