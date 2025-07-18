import 'package:flutter/material.dart';

class CustomCheckoutContainer extends StatelessWidget {
  const CustomCheckoutContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPriceRow('Subtotal', 'EGP 0.00'),
          const SizedBox(height: 12),
          _buildPriceRow('Delivery Fee', 'EGP 0.00'),
          const SizedBox(height: 12),
          Divider(color: Colors.grey[300]),
          const SizedBox(height: 12),
          _buildPriceRow('Total', 'EGP 0.00', isTotal: true),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFC58B3E),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 6,
              ),
              onPressed: () {
                // Handle checkout action
              },
              child: const Text(
                'Checkout',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildPriceRow(String title, String value, {bool isTotal = false}) {
  return Row(
    children: [
      Text(
        title,
        style: TextStyle(
          fontSize: isTotal ? 20 : 16,
          fontWeight: isTotal ? FontWeight.w800 : FontWeight.w600,
          color: isTotal ? Colors.black87 : Colors.grey[800],
        ),
      ),
      const Spacer(),
      Text(
        value,
        style: TextStyle(
          fontSize: isTotal ? 20 : 16,
          fontWeight: isTotal ? FontWeight.w800 : FontWeight.w600,
          color: isTotal ? Colors.green[700] : Colors.grey[900],
        ),
      ),
    ],
  );
}
