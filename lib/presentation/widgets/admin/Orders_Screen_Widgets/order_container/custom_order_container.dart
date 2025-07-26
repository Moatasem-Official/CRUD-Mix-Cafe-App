import 'package:flutter/material.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/Orders_Screen_Widgets/order_container/custom_collapsed_content.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/Orders_Screen_Widgets/order_container/custom_expanded_content.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/Orders_Screen_Widgets/order_container/helper_functions.dart';

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
  final bool isVip = true;

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
          gradient: const LinearGradient(
            colors: [Color(0xFFA56538), Color(0xFF5D4037)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            CustomCollapsedContent(
              isVip: isVip,
              glowAnimation: _glowAnimation,
              image: widget.image,
              customerName: widget.customerName,
              status: widget.status,
              color: HelperFunctions.getStatusColor(widget.status),
              blurRadius: _glowAnimation.value,
              spreadRadius: _glowAnimation.value / 2,
              orderDate: widget.date,
              orderTime: widget.time,
            ),

            CustomExpandedContent(
              isExpanded: _isExpanded,
              orderId: widget.orderId,
              date: widget.date,
              time: widget.time,
              onPressed: widget.onPressed,
            ),
          ],
        ),
      ),
    );
  }
}
