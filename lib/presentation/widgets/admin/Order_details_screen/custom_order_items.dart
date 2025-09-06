import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductListItem extends StatelessWidget {
  final String name;
  final int quantity;
  final double price;

  const ProductListItem({
    super.key,
    required this.name,
    required this.quantity,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            '$quantity x',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              color: const Color(0xFF4E342E),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(name, style: GoogleFonts.poppins())),
          const SizedBox(width: 12),
          Text(
            'EGP ${(price * quantity).toStringAsFixed(2)}',
            style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
