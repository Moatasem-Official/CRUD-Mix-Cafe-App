import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconly/iconly.dart';

class CustomActionButtons extends StatelessWidget {
  const CustomActionButtons({super.key, required this.onSave});

  final Function() onSave;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onSave,
      icon: const Icon(IconlyBold.tick_square, color: Colors.white),
      label: const Text('Save Changes', style: TextStyle(color: Colors.white)),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12),
        backgroundColor: const Color(0xFFC58B3E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        shadowColor: const Color(0xFFC58B3E).withOpacity(0.4),
      ),
    ).animate().slideY(
      begin: 1,
      delay: 400.ms,
      duration: 600.ms,
      curve: Curves.elasticOut,
    );
  }
}
