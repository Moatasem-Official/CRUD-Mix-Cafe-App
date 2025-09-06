import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import '../../../../data/model/product_model.dart';

class CustomProductDetailsContainer extends StatelessWidget {
  const CustomProductDetailsContainer({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    // ---- Logic Variables ----
    final hasDiscount = product.hasDiscount && product.discountedPrice > 0;
    final isFree = product.hasDiscount && product.discountedPrice == 0;
    final hasOfferDate =
        hasDiscount &&
        product.startDiscount != null &&
        product.endDiscount != null;

    return Container(
      // --- Main Container Styling ---
      decoration: BoxDecoration(
        color: const Color(0xFFFDFBF7), // لون كريمي دافئ
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.brown.withOpacity(0.15),
            blurRadius: 30,
            spreadRadius: 5,
            offset: const Offset(0, -10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(24, 12, 24, 30),
            child:
                Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // --- Drag Handle ---
                        Center(
                          child: Container(
                            width: 50,
                            height: 5,
                            margin: const EdgeInsetsDirectional.only(
                              bottom: 20,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),

                        // --- Header: Name & Discount Badge ---
                        _buildHeader(hasDiscount),
                        const SizedBox(height: 16),

                        // --- Description ---
                        _buildDescription(),
                        const SizedBox(height: 24),

                        // --- Info Chips: Availability, Offer Date, etc. ---
                        _buildInfoChips(context, hasOfferDate),
                        const SizedBox(height: 28),

                        // --- Divider ---
                        const Divider(color: Color(0xFFE0E0E0)),
                        const SizedBox(height: 20),

                        // --- Price & Add to Cart Button ---
                        _buildPriceAndAction(context, hasDiscount, isFree),
                      ],
                    )
                    .animate()
                    .fadeIn(duration: 500.ms)
                    .slideY(begin: 0.2, curve: Curves.easeOut),
          ),
        ),
      ),
    );
  }

  // --- Helper Widgets for Cleaner Code ---

  /// Header Section with Product Name and a stylish Discount Badge
  Widget _buildHeader(bool hasDiscount) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            product.name,
            style: GoogleFonts.poppins(
              fontSize: 28,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF3E2723), // Dark Brown
            ),
          ),
        ),
        if (hasDiscount && product.discountedPrice > 0)
          Container(
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: 10,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFFB74D), Color(0xFFFFA000)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.orange.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Text(
              '${double.parse((100 - ((product.discountedPrice / product.price) * 100)).toStringAsFixed(2)).toInt()}% OFF',
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ).animate().scale(delay: 200.ms),
      ],
    );
  }

  /// Description Section
  Widget _buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF6D4C41), // Medium Brown
          ),
        ),
        const SizedBox(height: 8),
        Text(
          product.description,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: const Color(0xFF5D4037).withOpacity(0.9), // Soft Brown
            height: 1.7,
          ),
        ),
      ],
    );
  }

  /// Info Chips Section
  Widget _buildInfoChips(BuildContext context, bool hasOfferDate) {
    return Wrap(
      spacing: 12.0, // horizontal space between chips
      runSpacing: 10.0, // vertical space between lines of chips
      children: [
        _buildInfoChip(
          icon: product.isAvailable
              ? IconlyLight.tick_square
              : IconlyLight.close_square,
          label: product.isAvailable ? 'Available' : 'Out of Stock',
          color: product.isAvailable ? Colors.teal : Colors.redAccent,
        ),
        _buildInfoChip(
          icon: IconlyLight.bag_2,
          label: '${product.quantity} pcs',
          color: Colors.blueGrey,
        ),
        if (hasOfferDate)
          _buildInfoChip(
            icon: IconlyLight.time_circle,
            label:
                'Offer: ${_formatDate(product.startDiscount!)} - ${_formatDate(product.endDiscount!)}',
            color: Colors.deepOrange,
          ),
      ],
    );
  }

  /// Reusable Chip Widget for displaying information
  Widget _buildInfoChip({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 8),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  /// Price and Call-to-Action Button Section
  Widget _buildPriceAndAction(
    BuildContext context,
    bool hasDiscount,
    bool isFree,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // --- Price Column ---
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Price',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 4),
            if (isFree)
              Text(
                'Free',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF4CAF50), // Green for Free
                ),
              )
            else if (hasDiscount)
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'EGP ${product.discountedPrice.toStringAsFixed(2)}',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF3E2723),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'EGP ${product.price.toStringAsFixed(2)}',
                    style: GoogleFonts.poppins(
                      decoration: TextDecoration.lineThrough,
                      color: Colors.grey.shade500,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              )
            else
              Text(
                'EGP ${product.price.toStringAsFixed(2)}',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF3E2723),
                ),
              ),
          ],
        ).animate().scale(delay: 300.ms),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}'; // Shorter format is cleaner
  }
}
