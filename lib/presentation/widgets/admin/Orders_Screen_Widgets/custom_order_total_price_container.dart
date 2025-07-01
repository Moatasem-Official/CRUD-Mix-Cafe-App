import 'package:flutter/material.dart';

class CustomOrderTotalPriceContainer extends StatelessWidget {
  const CustomOrderTotalPriceContainer({super.key, required this.totalPrice});

  final String totalPrice;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 28),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFCFA),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE7DACC), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.brown.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// Total label with icon
          Row(
            children: [
              const Icon(
                Icons.shopping_bag_rounded,
                color: Color(0xFF8B4513),
                size: 26,
              ),
              const SizedBox(width: 10),
              const Text(
                "Total Amount",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF4E342E),
                ),
              ),
            ],
          ),

          /// Total price
          Text(
            "$totalPrice EGP",
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF8B4513),
            ),
          ),
        ],
      ),
    );
  }
}
