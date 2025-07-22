import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconly/iconly.dart';
import 'dart:math' as math;

import 'package:mix_cafe_app/data/model/product_model.dart';

// Helper class to hold status information (color, icon)
class StatusInfo {
  final Color color;
  final IconData icon;

  StatusInfo({required this.color, required this.icon});
}

class OrderCard extends StatelessWidget {
  final String orderId;
  final String date;
  final String status;
  final double totalPrice;
  final List<dynamic> products;

  const OrderCard({
    super.key,
    required this.orderId,
    required this.date,
    required this.status,
    required this.totalPrice,
    required this.products,
  });

  // Returns a helper class with both color and icon for the status
  StatusInfo getStatusInfo(String status) {
    switch (status.toLowerCase()) {
      case 'delivered':
        return StatusInfo(
          color: const Color(0xFF2E7D32),
          icon: IconlyBold.tick_square,
        ); // Dark Green
      case 'pending':
        return StatusInfo(
          color: const Color(0xFFEF6C00),
          icon: IconlyBold.time_circle,
        ); // Amber
      case 'cancelled':
        return StatusInfo(
          color: const Color(0xFFC62828),
          icon: IconlyBold.close_square,
        ); // Dark Red
      default:
        return StatusInfo(color: Colors.blueGrey, icon: IconlyBold.info_square);
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusInfo = getStatusInfo(status);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child:
          Stack(
                clipBehavior: Clip.none,
                children: [
                  // Main Card Body
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFDF9),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 25,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ✨ 1. Header with Order ID only
                        _buildHeader(),
                        const SizedBox(height: 10),

                        // ✨ 2. New Date Chip
                        _buildDateChip(),
                        const SizedBox(height: 16),

                        // --- Products ---
                        _buildProductChips(),
                        const SizedBox(height: 20),

                        // --- Custom Dashed Separator ---
                        CustomPaint(painter: DashedLinePainter()),
                        const SizedBox(height: 20),

                        // --- Footer: Total Price & Actions ---
                        _buildFooter(context),
                      ],
                    ),
                  ),

                  // --- Status Ribbon ---
                  _buildStatusRibbon(statusInfo),
                ],
              )
              .animate()
              .fadeIn(duration: 400.ms)
              .slideX(begin: -0.1, curve: Curves.easeOutCubic),
    );
  }

  /// Builds the top part of the card with Order ID and Date.
  /// Builds the top part of the card with Order ID ONLY.
  Widget _buildHeader() {
    return Text(
      'Order #$orderId',
      style: GoogleFonts.poppins(
        fontWeight: FontWeight.w600,
        fontSize: 18,
        color: const Color(0xFF4E342E), // Rich brown
      ),
    );
  }

  /// Builds the product chips list.
  Widget _buildProductChips() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: products
          .whereType<Map<String, dynamic>>()
          .map(
            (product) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: const Color(0xFF4E342E).withOpacity(0.05),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                product['name'] ?? 'No Name',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: const Color(0xFF6D4C41),
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  /// Builds the bottom part with total price and action buttons.
  Widget _buildFooter(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Total Price
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total',
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
            Text(
              'EGP ${totalPrice.toStringAsFixed(2)}',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF3E2723),
              ),
            ),
          ],
        ),
        // Action Buttons
        Row(
          children: [
            OutlinedButton(
              onPressed: () {
                /* View Details Logic */
              },
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                foregroundColor: const Color(0xFF5D4037),
                side: BorderSide(color: Colors.grey.shade300),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Details',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: status == 'pending' ? null : () {} /* Reorder Logic */,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4E342E), // Rich brown
                foregroundColor: Colors.white,
                elevation: 2,
                shadowColor: const Color(0xFF4E342E).withOpacity(0.5),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Reorder',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Builds the status ribbon in the top-right corner.
  /// Builds the status ribbon in the top-right corner.
  Widget _buildStatusRibbon(StatusInfo statusInfo) {
    return Positioned(
      top: -10, // <-- تم تقليل الإزاحة العلوية
      right: 10,
      child: Container(
        // ✨ تم تقليل الحشو الداخلي (Padding)
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
        decoration: BoxDecoration(
          color: statusInfo.color,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10), // <-- تم تقليل الحواف
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(4),
            bottomRight: Radius.circular(4),
          ),
          boxShadow: [
            BoxShadow(
              color: statusInfo.color.withOpacity(0.3),
              blurRadius: 8, // <-- تم تقليل الظل
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            // ✨ تم تصغير حجم الأيقونة
            Icon(statusInfo.icon, color: Colors.white, size: 22),
            const SizedBox(height: 4),
            Text(
              status.toUpperCase(),
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                // ✨ تم تصغير حجم الخط
                fontSize: 10,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds a stylish chip to display the order date.
  Widget _buildDateChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.blueGrey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      // Use MainAxisSize.min to make the row only as wide as its content
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(IconlyLight.calendar, size: 18, color: Colors.blueGrey.shade700),
          const SizedBox(width: 8),
          Text(
            date,
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.blueGrey.shade800,
            ),
          ),
        ],
      ),
    );
  }
}

/// A custom painter for drawing a dashed line.
class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 5, dashSpace = 4, startX = 0;
    final paint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = 1;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
