import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconly/iconly.dart';
import 'package:mix_cafe_app/data/model/product_model.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final double price;
  final double discountPercentage;
  final int quantity;
  final bool isAvailable;
  final bool hasDiscount;
  final DateTime? offerStartDate;
  final DateTime? offerEndDate;
  final Function()? onAddToCart;
  final ProductModel product;

  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.discountPercentage,
    required this.quantity,
    required this.isAvailable,
    required this.hasDiscount,
    this.offerStartDate,
    this.offerEndDate,
    this.onAddToCart,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
          onTap: () => Navigator.pushNamed(
            context,
            '/customerShowProductDetails',
            arguments: product,
          ),
          borderRadius: BorderRadius.circular(20),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFFFFDF9), // Warm off-white
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.07),
                  blurRadius: 20,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // --- Product Image & Discount Badge ---
                  _buildImageSection(),

                  // --- Product Details ---
                  _buildDetailsSection(context),
                ],
              ),
            ),
          ),
        )
        .animate()
        .fadeIn(duration: 500.ms, curve: Curves.easeOut)
        .slideX(begin: -0.1);
  }

  /// Builds the left part of the card with the image and a discount badge.
  Widget _buildImageSection() {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        Container(
          width: 110,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        if (hasDiscount && discountPercentage > 0)
          Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFC62828), // Dark Red
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              '${discountPercentage.toInt()}%',
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
      ],
    );
  }

  /// Builds the right part of the card with product name, price, and actions.
  Widget _buildDetailsSection(BuildContext context) {
    final discountedPrice = price - (price * discountPercentage / 100);

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // --- Name and Availability ---
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF4E342E),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      isAvailable ? Icons.check_circle : Icons.remove_circle,
                      size: 14,
                      color: isAvailable ? Colors.teal : Colors.redAccent,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      isAvailable ? 'In Stock' : 'Out of Stock',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: isAvailable ? Colors.teal : Colors.redAccent,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // --- Price and Add to Cart Button ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Price
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (hasDiscount && discountPercentage > 0)
                      Text(
                        'EGP ${price.toStringAsFixed(2)}',
                        style: GoogleFonts.poppins(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey.shade500,
                          fontSize: 12,
                        ),
                      ),
                    Text(
                      discountedPrice == 0 && hasDiscount
                          ? 'Free'
                          : discountedPrice == 0 && !hasDiscount
                          ? 'EGP ${price.toStringAsFixed(2)}'
                          : 'EGP ${discountedPrice.toStringAsFixed(2)}',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF3E2723),
                      ),
                    ),
                  ],
                ),

                // Add to Cart Button
                SizedBox(
                  width: 44,
                  height: 44,
                  child: ElevatedButton(
                    onPressed: isAvailable ? onAddToCart : null,
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: EdgeInsets.zero,
                      backgroundColor: const Color(0xFF4E342E),
                      foregroundColor: Colors.white,
                      elevation: 4,
                      shadowColor: const Color(0xFF4E342E).withOpacity(0.5),
                      disabledBackgroundColor: Colors.grey.shade300,
                    ),
                    child: const Icon(IconlyBold.buy, size: 22),
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
