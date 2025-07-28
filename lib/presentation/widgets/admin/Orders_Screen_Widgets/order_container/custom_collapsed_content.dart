import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../constants/app_assets.dart';

class CustomCollapsedContent extends StatelessWidget {
  const CustomCollapsedContent({
    super.key,
    required this.customerName,
    required this.orderDate,
    required this.orderTime,
    required this.status,
    required this.image,
    required this.isVip,
    required this.blurRadius,
    required this.spreadRadius,
    required this.color,
    required this.glowAnimation,
  });

  final String customerName;
  final String orderDate;
  final String orderTime;
  final String status;
  final String image;
  final bool isVip;
  final double blurRadius;
  final double spreadRadius;
  final Color color;
  final Listenable glowAnimation;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        isVip
            ? AnimatedBuilder(
                animation: glowAnimation,
                builder: (context, child) {
                  return Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFFFD700).withOpacity(0.5),
                          blurRadius: blurRadius,
                          spreadRadius: spreadRadius,
                        ),
                      ],
                    ),
                    child: child,
                  );
                },
                child: CircleAvatar(
                  radius: 28,
                  backgroundImage: NetworkImage(
                    image.isEmpty ? Assets.mixCafeCustomerImage : image,
                  ),
                ),
              )
            : CircleAvatar(
                radius: 28,
                backgroundImage: NetworkImage(
                  image.isEmpty ? Assets.mixCafeCustomerImage : image,
                ),
              ),

        const SizedBox(width: 16),

        // Customer Name & Status
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              customerName,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  status,
                  style: GoogleFonts.poppins(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
