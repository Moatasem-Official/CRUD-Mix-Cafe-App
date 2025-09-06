import 'package:flutter/material.dart';
import 'custom_admin_account_row.dart';

class AdminAccountContainer extends StatelessWidget {
  const AdminAccountContainer({super.key, required this.adminEmail});

  final String adminEmail;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.all(16),
      margin: const EdgeInsetsDirectional.only(top: 16, start: 16, end: 16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 165, 101, 56), // خلفية بنية داكنة
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Admin Account',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          CustomAdminAccountRowWidget(icon: Icons.email, text: adminEmail),
        ],
      ),
    );
  }
}
