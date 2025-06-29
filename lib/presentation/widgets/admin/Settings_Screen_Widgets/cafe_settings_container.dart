import 'package:flutter/material.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/Settings_Screen_Widgets/activate_orders_with_switch_row.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/Settings_Screen_Widgets/custom_cafe_settings_row.dart';

class CafeSettingsContainer extends StatelessWidget {
  const CafeSettingsContainer({
    super.key,
    required this.isOrdersActivated,
    required this.onOrdersSwitchChanged,
  });

  final bool isOrdersActivated;
  final void Function(bool) onOrdersSwitchChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 165, 101, 56),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Cafe Settings',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          // Activate orders with switch
          ActivateOrdersWithSwitchRow(
            isOrdersActivated: isOrdersActivated,
            onOrdersSwitchChanged: onOrdersSwitchChanged,
          ),
          const SizedBox(height: 12),
          // Public Contact Number
          CustomCafeSettingsRowWidget(
            icon: Icons.phone,
            text: 'Public Contact Number',
          ),
          const SizedBox(height: 12),
          // Working Hours Display
          CustomCafeSettingsRowWidget(
            icon: Icons.access_time,
            text: 'Working Hours Display',
          ),
        ],
      ),
    );
  }
}
