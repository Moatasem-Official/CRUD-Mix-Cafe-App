import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';

class CustomCategoryDropDown extends StatelessWidget {
  const CustomCategoryDropDown({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategoryChanged,
  });

  final List<String> categories;
  final String selectedCategory;
  final void Function(String) onCategoryChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedCategory,
      onChanged: (value) {
        if (value != null) {
          onCategoryChanged(value);
        }
      },
      style: GoogleFonts.poppins(color: const Color(0xFF4E342E)),
      decoration: InputDecoration(
        labelText: 'Category',
        prefixIcon: const Icon(IconlyLight.category, color: Color(0xFFC58B3E)),
        filled: true,
        fillColor: const Color(0xFF4E342E).withOpacity(0.05),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      items: categories.map((category) {
        return DropdownMenuItem(value: category, child: Text(category));
      }).toList(),
    );
  }
}
