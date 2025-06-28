import 'package:flutter/material.dart';

class CustomAdminAccountRowWidget extends StatelessWidget {
  const CustomAdminAccountRowWidget({
    super.key,
    required this.text,
    required this.icon,
    this.onTap,
  });

  final String text;
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF3B2A1F),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white70),
          const SizedBox(width: 12),
          Expanded(
            child: Text(text, style: const TextStyle(color: Colors.white)),
          ),
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white),
            onPressed: onTap,
          ),
        ],
      ),
    );
  }
}
