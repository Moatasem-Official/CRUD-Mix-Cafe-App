import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'dart:ui';
import '../../../../constants/app_assets.dart';

class AuroraOrderCard extends StatefulWidget {
  const AuroraOrderCard({
    super.key,
    required this.customerName,
    required this.orderId,
    required this.date,
    required this.status,
    required this.time,
    required this.onPressed,
    required this.image,
  });

  final String customerName;
  final String orderId;
  final String date;
  final String time;
  final String status;
  final String image;
  final Function() onPressed;

  @override
  State<AuroraOrderCard> createState() => _AuroraOrderCardState();
}

class _AuroraOrderCardState extends State<AuroraOrderCard>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _animationController;
  late Animation<double> _glowAnimation;
  final bool isVip = true; // For demonstration

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _glowAnimation = Tween<double>(begin: 4.0, end: 8.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Helper for status colors
  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'delivered':
        return const Color(0xFF4CAF50);
      case 'pending':
        return const Color(0xFFFFC107);
      case 'cancelled':
        return const Color(0xFFF44336);
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.fastOutSlowIn,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        height: _isExpanded ? 200 : 100,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          // --- ✨ تم تطبيق درجات البني الجديدة هنا ✨ ---
          gradient: const LinearGradient(
            colors: [
              Color(0xFFA56538), // اللون الذي أرسلته
              Color(0xFF5D4037), // درجة بني أغمق للتدرج
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            // --- Always Visible Top Row ---
            _buildCollapsedContent(),

            // --- Expanded Section ---
            _buildExpandedContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildCollapsedContent() {
    return Row(
      children: [
        // Pulsating VIP Avatar
        isVip
            ? AnimatedBuilder(
                animation: _glowAnimation,
                builder: (context, child) {
                  return Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFFFD700).withOpacity(0.5),
                          blurRadius: _glowAnimation.value,
                          spreadRadius: _glowAnimation.value / 2,
                        ),
                      ],
                    ),
                    child: child,
                  );
                },
                child: CircleAvatar(
                  radius: 28,
                  backgroundImage: NetworkImage(
                    widget.image.isEmpty
                        ? Assets.mixCafeCustomerImage
                        : widget.image,
                  ),
                ),
              )
            : CircleAvatar(
                radius: 28,
                backgroundImage: NetworkImage(
                  widget.image.isEmpty
                      ? Assets.mixCafeCustomerImage
                      : widget.image,
                ),
              ),

        const SizedBox(width: 16),

        // Customer Name & Status
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.customerName,
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
                    color: _getStatusColor(widget.status),
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  widget.status,
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

  Widget _buildExpandedContent() {
    return Expanded(
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn,
        opacity: _isExpanded ? 1.0 : 0.0,
        child: SingleChildScrollView(
          // To avoid overflow if content is too much
          padding: const EdgeInsets.only(top: 15),
          child: Column(
            children: [
              const Divider(color: Colors.white24),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ORDER ID',
                        style: GoogleFonts.poppins(
                          color: Colors.white54,
                          fontSize: 10,
                          letterSpacing: 1,
                        ),
                      ),
                      Text(
                        '#${widget.orderId}',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'TIME',
                        style: GoogleFonts.poppins(
                          color: Colors.white54,
                          fontSize: 10,
                          letterSpacing: 1,
                        ),
                      ),
                      Text(
                        '${widget.date} - ${widget.time}',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: widget.onPressed,
                  icon: Text(
                    'View Details',
                    style: GoogleFonts.poppins(color: const Color(0xFFFFD700)),
                  ),
                  label: const Icon(
                    IconlyLight.arrow_right_2,
                    color: Color(0xFFFFD700),
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Helper class to create the ticket shape
// Helper class to create the ticket shape
class TicketClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    // Move to the start of the right side of the notch
    path.moveTo(40, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(40, size.height);
    // Create the arc for the notch
    path.arcToPoint(
      const Offset(40, 0),
      radius: const Radius.circular(40),
      clockwise: false,
    );
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// Helper class to draw a dashed line
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
  bool shouldReclip(CustomPainter oldDelegate) => false;

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
