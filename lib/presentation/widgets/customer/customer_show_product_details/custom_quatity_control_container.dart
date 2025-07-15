import 'package:flutter/material.dart';

class CustomQuatityControlContainer extends StatelessWidget {
  const CustomQuatityControlContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF9F0),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFFFEED9), // بيج أدكن
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.remove),
              color: const Color(0xFF9C6B1C),
              onPressed: () {},
              splashRadius: 20,
            ),
          ),

          const SizedBox(width: 16),

          const Text(
            '1',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF222222),
            ),
          ),

          const SizedBox(width: 16),

          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFFFEED9),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.add),
              color: const Color(0xFF9C6B1C),
              onPressed: () {},
              splashRadius: 20,
            ),
          ),
        ],
      ),
    );
  }
}
