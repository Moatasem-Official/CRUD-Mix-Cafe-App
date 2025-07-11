import 'package:flutter/material.dart';
import 'package:mix_cafe_app/data/services/auth/auth_service.dart';

class AdminLogOut extends StatelessWidget {
  const AdminLogOut({super.key, required AuthService authService})
    : _authService = authService;

  final AuthService _authService;

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
          onPressed: () => Navigator.pop(context),
          child: const Text('لا'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF8B4513),
          ),
          onPressed: () async {
            await _authService.signOut();
            Navigator.of(context).pushReplacementNamed('/adminLogin');
          },
          child: const Text('نعم'),
        ),
      ],
    );
  }
}
