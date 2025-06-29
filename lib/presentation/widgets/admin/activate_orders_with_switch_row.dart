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
            activeTrackColor: const Color.fromARGB(255, 96, 57, 42),
            inactiveTrackColor: Colors.grey[300],
            value: isOrdersActivated,
            activeColor: Colors.brown[300],
            inactiveThumbColor: Colors.grey,
            onChanged: onOrdersSwitchChanged,
          ),
        ],
      ),
    );
  }
}
