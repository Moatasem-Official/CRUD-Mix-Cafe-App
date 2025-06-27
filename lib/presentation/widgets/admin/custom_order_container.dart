import 'package:flutter/material.dart';

class CustomOrderContainerTemplete extends StatelessWidget {
  const CustomOrderContainerTemplete({
    super.key,
    required this.customerName,
    required this.orderId,
    required this.date,
    required this.status,
  });

  final String customerName;
  final String orderId;
  final String date;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left side: customer info
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                customerName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Order ID: $orderId',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
              ),
              const SizedBox(height: 2),
              Text(
                'Date: $date',
                style: TextStyle(color: Colors.grey.shade400, fontSize: 13),
              ),
            ],
          ),

          // Right side: Status badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: status == 'Pending'
                  ? const Color(0xFFFFF4D6)
                  : status == 'In Progress'
                  ? Color(0xFFE0F0FF)
                  : Color(0xFFE6FFED),
              border: Border.all(
                color: status == 'Pending'
                    ? const Color(0xFFF9C400)
                    : status == 'In Progress'
                    ? const Color(0xFFAECBFF)
                    : const Color(0xFFB7E8C1),
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              status,
              style: TextStyle(
                color: status == 'Pending'
                    ? Color(0xFFC58F00)
                    : status == 'In Progress'
                    ? Color(0xFF4285F4)
                    : Color(0xFF34A853),
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
