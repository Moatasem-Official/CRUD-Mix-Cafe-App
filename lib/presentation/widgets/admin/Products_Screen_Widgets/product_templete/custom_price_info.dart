import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomPriceInfo extends StatelessWidget {
  const CustomPriceInfo({
    super.key,
    required this.isHasDiscount,
    required this.productPrice,
    required this.discountPrice,
  });

  final bool isHasDiscount;
  final double productPrice;
  final double discountPrice;

  @override
  Widget build(BuildContext context) {
    final finalPrice = isHasDiscount ? discountPrice : productPrice;
    return Row(
      children: [
        if (isHasDiscount) ...[
          Text(
            'EGP ${productPrice.toStringAsFixed(2)}',
            style: GoogleFonts.poppins(
              decoration: TextDecoration.lineThrough,
              color: Colors.red.shade400,
              fontSize: 13,
            ),
          ),
          const SizedBox(width: 8),
        ],
        Text(
          finalPrice <= 0 ? 'Free' : 'EGP ${finalPrice.toStringAsFixed(2)}',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: finalPrice <= 0
                ? Colors.green.shade700
                : const Color(0xFF4E342E),
          ),
        ),
      ],
    );
  }
}
