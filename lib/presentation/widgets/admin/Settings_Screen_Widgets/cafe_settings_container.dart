import 'package:flutter/material.dart';
import 'activate_orders_with_switch_row.dart';
import 'custom_cafe_settings_row.dart';

class CafeSettingsContainer extends StatelessWidget {
  const CafeSettingsContainer({
    super.key,
    required this.isOrdersActivated,
    required this.onOrdersSwitchChanged,
    this.onPublicNumberTap,
    this.onWorkingHoursTap,
    this.publicContactNumber,
    this.startWorkingHours,
    this.endWorkingHours,
  });

  final bool isOrdersActivated;
  final String? publicContactNumber;
  final String? startWorkingHours;
  final String? endWorkingHours;
  final void Function(bool) onOrdersSwitchChanged;
  final void Function()? onPublicNumberTap;
  final void Function()? onWorkingHoursTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.all(16),
      margin: const EdgeInsetsDirectional.only(top: 16, start: 16, end: 16),
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
            text: publicContactNumber ?? 'Public Contact Number',
            onTap: onPublicNumberTap,
          ),
          const SizedBox(height: 12),
          // Working Hours Display
          CustomCafeSettingsRowWidget(
            icon: Icons.access_time,
            text: '$startWorkingHours - $endWorkingHours',
            onTap: onWorkingHoursTap,
          ),
        ],
      ),
    );
  }
}
