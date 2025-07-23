import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import '../../../../constants/app_assets.dart';

class CustomProductTemplate extends StatelessWidget {
  const CustomProductTemplate({
    super.key,
    required this.productName,
    required this.productDescription,
    required this.imagePath,
    required this.productPrice,
    required this.isHasDiscount,
    required this.discountPrice,
    required this.onDelete,
    required this.onEdit,
  });

  final String productName;
  final String productDescription;
  final String imagePath;
  final double productPrice;
  final bool isHasDiscount;
  final double discountPrice;
  final Function() onDelete;
  final Function() onEdit;

  @override
  Widget build(BuildContext context) {
    // --- ✨ 1. حساب نسبة الخصم تلقائيًا ✨ ---
    double discountPercentage = 0;
    if (isHasDiscount && productPrice > 0) {
      discountPercentage =
          ((productPrice - discountPrice) / productPrice) * 100;
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image with Discount Ribbon
          Stack(
            clipBehavior: Clip.none,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  imagePath.isEmpty
                      ? 'https://via.placeholder.com/100'
                      : imagePath,
                  width: 100,
                  height: 120,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Image.asset(
                    Assets.mixCafeCustomerFoodImage,
                    width: 100,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Show ribbon only if there is a valid discount
              if (isHasDiscount && discountPercentage > 0)
                Positioned(
                  top: -4,
                  left: -4,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: const BoxDecoration(
                      color: Color(0xFFC62828),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                    // --- ✨ 2. عرض النسبة المئوية هنا ✨ ---
                    child: Text(
                      '${discountPercentage.toInt()}% OFF',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),
          // Details
          Expanded(
            child: SizedBox(
              height: 120,
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
                  _buildPriceInfo(),
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
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                        ),
                      ),
                      const SizedBox(width: 8),
                      TextButton.icon(
                        onPressed: onDelete,
                        icon: const Icon(IconlyLight.delete, size: 18),
                        label: Text('Delete', style: GoogleFonts.poppins()),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.red.shade700,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceInfo() {
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
