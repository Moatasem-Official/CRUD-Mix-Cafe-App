import 'package:flutter/material.dart';

class CustomDateField extends StatelessWidget {
  const CustomDateField({
    super.key,
    required this.controller,
    required this.label,
    required this.context,
    this.selectedDate,
    required this.onDatePicked,
  });

  final TextEditingController controller;
  final String label;
  final BuildContext context;
  final DateTime? selectedDate;
  final void Function(DateTime) onDatePicked;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        readOnly: true,
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Color(0xFF8B4513)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          prefixIcon: const Icon(Icons.date_range, color: Color(0xFF8B4513)),
          filled: true,
          fillColor: const Color(0xFFFDF9F6),
        ),
        onTap: () async {
          DateTime now = DateTime.now();
          DateTime? picked = await showDatePicker(
            context: context,
            initialDate: selectedDate ?? now,
            firstDate: DateTime(now.year - 5),
            lastDate: DateTime(now.year + 5),
          );
          if (picked != null) {
            controller.text =
                "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
            onDatePicked(picked);
          }
        },
      ),
    );
  }
}
