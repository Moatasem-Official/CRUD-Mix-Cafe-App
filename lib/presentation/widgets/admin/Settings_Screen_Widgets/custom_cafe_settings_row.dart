import 'package:flutter/material.dart';

class CustomCafeSettingsRowWidget extends StatelessWidget {
  const CustomCafeSettingsRowWidget({
    super.key,
    required this.text,
    required this.icon,
    this.onTap,
  });

  final String text;
  final IconData icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: 12,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 137, 86, 50),
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
            onPressed: onTap,
            icon: const Icon(Icons.edit, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
