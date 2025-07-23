import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomOrdersTabBarItem extends StatelessWidget {
  const CustomOrdersTabBarItem({
    super.key,
    required this.itemText,
    required this.onTap,
    required this.isSelected,
  });

  final String itemText;
  final VoidCallback onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 300),
          style: GoogleFonts.poppins(
            color: isSelected ? Colors.white : const Color(0xFF6F4E37),
            fontSize: 15,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
          ),
          child: Text(itemText, textAlign: TextAlign.center),
        ),
      ),
    );
  }
}
