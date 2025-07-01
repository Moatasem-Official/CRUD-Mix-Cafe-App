import 'package:flutter/material.dart';

class CustomerDetailsCard extends StatelessWidget {
  const CustomerDetailsCard({
    super.key,
    required this.cardTitle,
    required this.cardFirstRowValue,
    required this.cardSecondRowValue,
    required this.cardThirdRowValue,
  });

  final String cardTitle;
  final String cardFirstRowValue;
  final String cardSecondRowValue;
  final String cardThirdRowValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFFDF9F6),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.brown.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            cardTitle,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.brown,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.person, size: 20, color: Colors.brown),
              SizedBox(width: 8),
              Text(cardFirstRowValue),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.phone, size: 20, color: Colors.brown),
              SizedBox(width: 8),
              Text(cardSecondRowValue),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.location_on, size: 20, color: Colors.brown),
              SizedBox(width: 8),
              Text(cardThirdRowValue),
            ],
          ),
        ],
      ),
    );
  }
}
