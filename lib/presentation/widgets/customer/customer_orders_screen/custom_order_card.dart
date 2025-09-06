import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconly/iconly.dart';
import 'package:mix_cafe_app/bussines_logic/cubits/customer/orders_screen/cubit/orders_screen_cubit.dart';
import '../../../../data/helpers/search_helper.dart';

class StatusInfo {
  final Color color;
  final IconData icon;

  StatusInfo({required this.color, required this.icon});
}

class OrderCard extends StatelessWidget {
  final String orderCount;
  final String orderId;
  final String userId;
  final String preparingTime;
  final String date;
  final String status;
  final double totalPrice;
  final List<dynamic> products;

  const OrderCard({
    super.key,
    required this.orderCount,
    required this.orderId,
    required this.userId,
    required this.preparingTime,
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
      margin: const EdgeInsetsDirectional.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      child:
          Stack(
                clipBehavior: Clip.none,
                children: [
                  // Main Card Body
                  Container(
                    padding: const EdgeInsetsDirectional.all(20),
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
                        _buildOrderDetailsTile(
                          products.cast<Map<String, dynamic>>(),
                        ),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Order #$orderCount',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: const Color(0xFF4E342E), // Rich brown
          ),
        ),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: 8,
            vertical: 4,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF9F0),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            'Preparing Time : $preparingTime',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 12,
              color: const Color(0xFF4E342E),
            ),
          ),
        ),
      ],
    );
  }

  /// Builds the product chips list.
  Widget _buildOrderDetailsTile(List<Map<String, dynamic>> products) {
    // يمكنك تغيير هذا اللون ليتناسب مع تصميمك
    const Color primaryColor = Color(0xFFC58B3E);
    const Color textColor = Color(0xFF4E342E);

    // لمنع ظهور الخطوط الافتراضية حول الـ ExpansionTile
    const borderShape = BorderSide.none;

    return Container(
      margin: const EdgeInsetsDirectional.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      // ClipRRect لضمان أن الخلفية الملونة عند الفتح لا تتجاوز الحواف الدائرية
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: ExpansionTile(
          // --- تصميم العنوان الرئيسي للـ Tile ---
          title: Text(
            'Order Details',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
          subtitle: Text(
            '${products.length} items',
            style: GoogleFonts.poppins(color: Colors.grey.shade600),
          ),
          leading: const Icon(IconlyBold.document),

          // --- التحكم في ألوان وأشكال الـ Tile ---
          shape: const Border(top: borderShape, bottom: borderShape),
          collapsedShape: const Border(top: borderShape, bottom: borderShape),
          backgroundColor: primaryColor.withOpacity(0.05),
          collapsedBackgroundColor: Colors.white,
          iconColor: primaryColor,
          collapsedIconColor: textColor,

          // --- المنتجات التي ستظهر عند فتح الـ Tile ---
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.all(16.0),
              // نستخدم نفس منطق الـ Wrap الذي قمنا ببنائه سابقًا
              child: _buildProductChipsInside(products),
            ),
          ],
        ),
      ),
    );
  }

  /// هذا الويدجت هو نفس منطق الـ Wrap السابق، ولكن تم وضعه هنا ليكون تابعاً للـ Tile
  Widget _buildProductChipsInside(List<Map<String, dynamic>> products) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: products
          .whereType<Map<String, dynamic>>()
          .map(
            (product) => Container(
              padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFECEFF1),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFCFD8DC)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      product['name'] ?? 'No Name',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF37474F),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsetsDirectional.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFC58B3E).withOpacity(0.8),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'x${product['quantity'] ?? 0}',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'EGP ${(product['price'] ?? 0.0).toStringAsFixed(2)}',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF455A64),
                    ),
                  ),
                ],
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: status == 'pending' ? null : () => _reorder(context),
              /* Reorder Logic */
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFC38154), // Rich brown
                foregroundColor: Colors.white,
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.replay_rounded, color: Colors.white),
                  const SizedBox(width: 8),
                  Text(
                    'Reorder',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: status == 'pending' ? () => _cancel(context) : null,
              /* Reorder Logic */
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4E342E), // Rich brown
                foregroundColor: Colors.white,
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.cancel_rounded, color: Colors.white),
                  const SizedBox(width: 8),
                  Text(
                    'Cancel',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _reorder(BuildContext context) {
    final cubit = BlocProvider.of<OrdersScreenCubit>(context);
    cubit.reOrder(orderId, userId);
  }

  void _cancel(BuildContext context) {
    final cubit = BlocProvider.of<OrdersScreenCubit>(context);
    cubit.cancelOrder(orderId, userId);
  }

  /// Builds the status ribbon in the top-right corner.
  /// Builds the status ribbon in the top-right corner.
  Widget _buildStatusRibbon(StatusInfo statusInfo) {
    return Positioned(
      top: -10, // <-- تم تقليل الإزاحة العلوية
      right: 10,
      child: Container(
        // ✨ تم تقليل الحشو الداخلي (Padding)
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: 10,
          vertical: 14,
        ),
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
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
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
