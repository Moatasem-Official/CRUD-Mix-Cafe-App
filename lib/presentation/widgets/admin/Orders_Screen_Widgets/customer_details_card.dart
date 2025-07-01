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
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFCFA),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFF1E9E2), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.brown.withOpacity(0.07),
            blurRadius: 10,
            offset: const Offset(0, 5),
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
            ),
          ),

          const SizedBox(height: 16),

          /// Name
          _buildDetailRow(
            icon: Icons.person_outline,
            label: "Name",
            value: cardFirstRowValue,
          ),

          const SizedBox(height: 12),

          /// Phone
          _buildDetailRow(
            icon: Icons.phone_iphone,
            label: "Phone",
            value: cardSecondRowValue,
          ),

          const SizedBox(height: 12),

          /// Address
          _buildDetailRow(
            icon: Icons.location_on_outlined,
            label: "Address",
            value: cardThirdRowValue,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: const Color(0xFF8B4513), size: 20),
        const SizedBox(width: 10),
        Expanded(
          child: RichText(
            text: TextSpan(
              text: '$label: ',
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
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
        ),
      ],
    );
  }
}
