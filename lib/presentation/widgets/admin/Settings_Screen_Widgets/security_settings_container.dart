import 'package:flutter/material.dart';
import 'custom_admin_account_row.dart';

class SecuritySettingsContainer extends StatelessWidget {
  const SecuritySettingsContainer({super.key, required this.onLogoutPressed});

  final Function() onLogoutPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 165, 101, 56),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Security',
            style: TextStyle(
              color: Color(0xFFF5E4C3),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: onLogoutPressed,
            child: CustomAdminAccountRowWidget(
              icon: Icons.logout,
              text: 'LOG OUT',
            ),
          ),
        ],
      ),
    );
  }
}
