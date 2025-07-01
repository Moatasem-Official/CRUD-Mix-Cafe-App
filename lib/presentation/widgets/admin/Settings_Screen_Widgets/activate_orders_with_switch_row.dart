import 'package:flutter/material.dart';

class ActivateOrdersWithSwitchRow extends StatelessWidget {
  const ActivateOrdersWithSwitchRow({
    super.key,
    required this.isOrdersActivated,
    required this.onOrdersSwitchChanged,
  });

  final bool isOrdersActivated;
  final void Function(bool value) onOrdersSwitchChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 137, 86, 50),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.check, color: Colors.white70),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Activate orders',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Switch(
            activeColor: const Color.fromARGB(255, 219, 162, 118), // بني غني
            inactiveThumbColor: const Color.fromARGB(
              255,
              106,
              75,
              44,
            ), // بيج ناعم
            inactiveTrackColor: const Color(
              0xFFF3E3D3,
            ), // بيج أفتح لمسار التراك
            trackOutlineColor: WidgetStateProperty.all(
              const Color(0xFFDCC6B1), // تحديد بسيط للمسار
            ),
            splashRadius: 20,
            value: isOrdersActivated,
            onChanged: onOrdersSwitchChanged,
          ),
        ],
      ),
    );
  }
}
