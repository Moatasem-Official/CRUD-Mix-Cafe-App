import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/Order_details_screen/helper_functions.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({
    super.key,
    required this.orderId,
    required this.currentStatus,
  });

  final String orderId;
  final String currentStatus;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      floating: true,
      expandedHeight: 160.0,
      backgroundColor: const Color(0xFF4E342E),
      iconTheme: const IconThemeData(color: Colors.white),
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
        title: Text(
          'Order #$orderId',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        background: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF5D4037), Color(0xFF3E2723)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: HelperFunctions.getStatusColor(
                    currentStatus,
                  ).withOpacity(0.9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  currentStatus.toUpperCase(),
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(height: 45), // Space for the title to settle
            ],
          ),
        ),
      ),
    );
  }
}
