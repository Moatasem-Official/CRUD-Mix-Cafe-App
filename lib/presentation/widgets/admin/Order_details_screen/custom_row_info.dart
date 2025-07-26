import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomRowInfo extends StatelessWidget {
  const CustomRowInfo({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              color: Colors.grey.shade600,
              fontSize: 14,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              color: Colors.black87,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
