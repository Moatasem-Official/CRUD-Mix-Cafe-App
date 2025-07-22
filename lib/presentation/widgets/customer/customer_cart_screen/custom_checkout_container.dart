import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';

// You will also need the TicketClipper and DashedLinePainter classes.
// I'm assuming DashedLinePainter is available from previous designs.

class CustomCheckoutContainer extends StatelessWidget {
  const CustomCheckoutContainer({
    super.key,
    required this.subTotal,
    required this.deliveryFee,
    required this.total,
    required this.onCheckout,
  });

  final double subTotal;
  final double deliveryFee;
  final double total;
  final Function() onCheckout;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFFDF9), // Warm off-white
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 30,
            offset: const Offset(0, -10),
          ),
        ],
      ),
      child: ClipPath(
        clipper: TicketClipper(),
        child: Container(
          color: const Color(
            0xFFF9F5EF,
          ), // A slightly darker beige for the ticket
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child:
              Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Drag handle
                      Container(
                        width: 50,
                        height: 5,
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),

                      Text(
                        'Order Summary',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF4E342E),
                        ),
                      ),
                      const SizedBox(height: 20),

                      _buildPriceRow(
                        icon: IconlyLight.bag,
                        'Subtotal',
                        'EGP ${subTotal.toStringAsFixed(2)}',
                      ),
                      const SizedBox(height: 16),
                      _buildPriceRow(
                        icon: IconlyLight.activity,
                        'Delivery Fee',
                        'EGP ${deliveryFee.toStringAsFixed(2)}',
                      ),
                      const SizedBox(height: 20),

                      // Dashed Separator
                      const Divider(
                        color: Color(0xFFD7CCC8),
                        height: 1,
                        indent: 5,
                        endIndent: 5,
                      ),

                      const SizedBox(height: 16),

                      // Total Amount Section
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFFDF9),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: _buildPriceRow(
                          icon: IconlyBold.wallet,
                          'Total',
                          'EGP ${total.toStringAsFixed(2)}',
                          isTotal: true,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Checkout Button
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton.icon(
                          icon: const Icon(IconlyBold.shield_done, size: 22),
                          label: Text(
                            'Proceed To Delivery Request',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: const Color(0xFF4E342E),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 5,
                            shadowColor: const Color(
                              0xFF4E342E,
                            ).withOpacity(0.4),
                          ),
                          onPressed: onCheckout,
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                  )
                  .animate()
                  .fadeIn(duration: 400.ms)
                  .slideY(begin: 0.1, curve: Curves.easeOut),
        ),
      ),
    );
  }

  Widget _buildPriceRow(
    String title,
    String value, {
    IconData? icon,
    bool isTotal = false,
  }) {
    final textStyle = GoogleFonts.poppins(
      fontSize: isTotal ? 18 : 15,
      fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
      color: isTotal ? const Color(0xFF3E2723) : const Color(0xFF5D4C41),
    );
    final valueStyle = textStyle.copyWith(
      color: isTotal ? const Color(0xFF4CAF50) : const Color(0xFF3E2723),
      fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
    );

    return Row(
      children: [
        if (icon != null) ...[
          Icon(icon, size: 20, color: const Color(0xFF8D6E63)),
          const SizedBox(width: 12),
        ],
        Text(title, style: textStyle),
        const Spacer(),
        Text(value, style: valueStyle),
      ],
    );
  }
}

class TicketClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    const double radius = 20.0; // Radius of the circular cutout

    // Start from top-left
    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.lineTo(0.0, 0.0);

    // Create the left cutout
    path.addOval(
      Rect.fromCircle(center: Offset(0, size.height / 2), radius: radius),
    );
    // Create the right cutout
    path.addOval(
      Rect.fromCircle(
        center: Offset(size.width, size.height / 2),
        radius: radius,
      ),
    );

    // Use path fill type to create the cutout effect
    path.fillType = PathFillType.evenOdd;
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
