import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomOfferPercentage extends StatelessWidget {
  const CustomOfferPercentage({super.key, required this.discountPercentage});

  final double discountPercentage;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -4,
      left: -4,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: const BoxDecoration(
          color: Color(0xFFC62828),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
        ),
        child: Text(
          '${discountPercentage.toInt()}% OFF',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
