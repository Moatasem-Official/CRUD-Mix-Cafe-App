import 'package:flutter/material.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/custom_cafe_settings_row.dart';

class SecuritySettingsContainer extends StatelessWidget {
  const SecuritySettingsContainer({super.key});

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
              color: Color(0xFFF5E4C3), // لون كريمي فاتح زي الصورة
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          CustomCafeSettingsRowWidget(icon: Icons.lock, text: 'Reset Password'),
          const SizedBox(height: 12),
          CustomCafeSettingsRowWidget(icon: Icons.logout, text: 'LOG OUT'),
        ],
      ),
    );
  }
}
