import 'package:flutter/material.dart';

class UpdateOrderStatusDropdown extends StatelessWidget {
  const UpdateOrderStatusDropdown({
    super.key,
    this.orderStatus,
    required this.statusOptions,
    this.onStatusChanged,
  });

  final String? orderStatus;
  final List<String> statusOptions;
  final void Function(String?)? onStatusChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: orderStatus,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFFDF9F6), // soft beige background
        labelText: "Update Order Status",
        labelStyle: const TextStyle(
          color: Colors.brown,
          fontWeight: FontWeight.bold,
        ),
        prefixIcon: const Icon(Icons.sync, color: Colors.brown),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.brown),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.brown),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.orange, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
      icon: const Icon(Icons.arrow_drop_down_circle, color: Colors.brown),
      dropdownColor: const Color(0xFFFFFAF0),
      items: statusOptions.map((String status) {
        return DropdownMenuItem<String>(
          value: status,
          child: Text(status, style: const TextStyle(fontSize: 16)),
        );
      }).toList(),
      onChanged: (value) {
        if (onStatusChanged != null) {
          onStatusChanged!(value);
        }
      },
    );
  }
}
