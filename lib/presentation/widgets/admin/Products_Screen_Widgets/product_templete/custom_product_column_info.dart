import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'custom_price_info.dart';

class CustomProductColumnInfo extends StatelessWidget {
  const CustomProductColumnInfo({
    super.key,
    required this.productName,
    required this.productDescription,
    required this.productPrice,
    required this.isHasDiscount,
    required this.discountPrice,
    required this.onEdit,
    required this.onDelete,
  });

  final String productName;
  final String productDescription;
  final double productPrice;
  final bool isHasDiscount;
  final double discountPrice;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: SizedBox(
        height: 135,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              productName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF3E2723),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              productDescription,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 8),
            CustomPriceInfo(
              productPrice: productPrice,
              isHasDiscount: isHasDiscount,
              discountPrice: discountPrice,
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: onEdit,
                  icon: const Icon(IconlyLight.edit, size: 18),
                  label: Text('Edit', style: GoogleFonts.poppins()),
                  style: TextButton.styleFrom(
                    foregroundColor: const Color(0xFF4E342E),
                    padding: const EdgeInsetsDirectional.symmetric(
                      horizontal: 12,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                TextButton.icon(
                  onPressed: onDelete,
                  icon: const Icon(IconlyLight.delete, size: 18),
                  label: Text('Delete', style: GoogleFonts.poppins()),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.red.shade700,
                    padding: const EdgeInsetsDirectional.symmetric(
                      horizontal: 12,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
