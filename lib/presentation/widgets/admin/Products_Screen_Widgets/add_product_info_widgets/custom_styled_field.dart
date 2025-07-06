import 'package:flutter/material.dart';

class CustomStyledField extends StatelessWidget {
  CustomStyledField({
    super.key,
    required this.controller,
    required this.label,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.validatorMessage,
  });
  final TextEditingController controller;
  final String label;
  int maxLines;
  final TextInputType keyboardType;
  String? Function(String?)? validator;
  String? validatorMessage;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        validator:
            validator ??
            (value) => value == null || value.isEmpty ? validatorMessage : null,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          labelStyle: const TextStyle(color: Color(0xFF8B4513)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFF8B4513)),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
