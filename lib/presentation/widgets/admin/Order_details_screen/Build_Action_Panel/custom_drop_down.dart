import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';

class CustomDropDown extends StatelessWidget {
  const CustomDropDown({
    super.key,
    required this.currentStatus,
    required this.statusOptions,
    this.onChanged,
  });

  final String currentStatus; // حالة الطلب الحالية
  final List<String> statusOptions;
  final Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: currentStatus,
      items: statusOptions.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value, style: GoogleFonts.poppins()),
        );
      }).toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: 'Update Order Status',
        labelStyle: GoogleFonts.poppins(),
        prefixIcon: const Icon(IconlyLight.edit),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
