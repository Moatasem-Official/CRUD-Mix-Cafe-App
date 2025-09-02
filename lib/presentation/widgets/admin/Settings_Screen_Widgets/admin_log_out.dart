import 'package:flutter/material.dart';

class AdminLogOut extends StatelessWidget {
  const AdminLogOut({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text(
        'تسجيل الخروج',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xFF8B4513),
        ),
      ),
      content: const Text('هل تريد تسجيل الخروج ؟'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('لا'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF8B4513),
          ),
          onPressed: () => Navigator.pop(context, true),
          child: const Text('نعم', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
