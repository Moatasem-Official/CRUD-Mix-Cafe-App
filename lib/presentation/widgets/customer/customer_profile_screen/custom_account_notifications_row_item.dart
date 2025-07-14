import 'package:flutter/material.dart';

class CustomAccountNotificationsRowItem extends StatelessWidget {
  const CustomAccountNotificationsRowItem({
    super.key,
    required this.title,
    required this.onChanged,
    required this.notificationsEnabled,
  });

  final String title;
  final bool notificationsEnabled;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 225, 225, 225),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Icon(
                Icons.notifications_rounded,
                color: const Color.fromARGB(255, 216, 165, 52),
              ),
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const Spacer(),
        Switch(
          value:
              notificationsEnabled,
          onChanged: onChanged,
          activeColor: const Color.fromARGB(255, 216, 165, 52),
          inactiveThumbColor: Colors.grey,
          inactiveTrackColor: Colors.grey.shade300,
        ),
      ],
    );
  }
}
