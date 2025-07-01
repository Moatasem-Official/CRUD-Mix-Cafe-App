import 'package:flutter/material.dart';

class OrderInformationCard extends StatelessWidget {
  const OrderInformationCard({
    super.key,
    required this.orderStatus,
    required this.cardTitle,
    required this.cardFirstRowValue,
    required this.cardSecondRowValue,
    required this.cardThirdRowValue,
  });

  final String orderStatus;
  final String cardTitle;
  final String cardFirstRowValue;
  final String cardSecondRowValue;
  final String cardThirdRowValue;

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.amber.shade100;
      case 'preparing':
        return Colors.orange.shade200;
      case 'delivered':
        return Colors.green.shade200;
      default:
        return Colors.grey.shade300;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFCFA),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFF1E9E2), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.brown.withOpacity(0.08),
            blurRadius: 12,
            spreadRadius: 2,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title
          Text(
            cardTitle,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xFF4E342E),
              letterSpacing: 0.5,
            ),
          ),

          const SizedBox(height: 16),

          /// First Row
          _buildInfoRow(
            icon: Icons.receipt_long_rounded,
            label: "Order Number",
            value: cardFirstRowValue,
          ),

          const SizedBox(height: 12),

          /// Second Row
          _buildInfoRow(
            icon: Icons.calendar_today_outlined,
            label: "Order Date",
            value: cardSecondRowValue,
          ),

          const SizedBox(height: 12),

          /// Third Row with status
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.info_outline,
                color: Color(0xFF8B4513),
                size: 20,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  cardThirdRowValue,
                  style: const TextStyle(fontSize: 15, color: Colors.black87),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: _getStatusColor(orderStatus),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  orderStatus,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF8B4513),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: const Color(0xFF8B4513), size: 20),
        const SizedBox(width: 8),
        RichText(
          text: TextSpan(
            text: '$label: ',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black87,
              fontSize: 15,
            ),
            children: [
              TextSpan(
                text: value,
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
