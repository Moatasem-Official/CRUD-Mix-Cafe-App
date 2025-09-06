import 'package:flutter/material.dart';

class CustomNotificationsNumStack extends StatelessWidget {
  const CustomNotificationsNumStack({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsetsDirectional.all(8),
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 237, 237, 237),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.notifications,
            color: Color.fromARGB(255, 165, 101, 56),
          ),
        ),
        Positioned(
          right: -2,
          top: -2,
          child: Container(
            padding: const EdgeInsetsDirectional.all(4),
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
            child: const Text(
              '10', // ← عدل الرقم حسب الإشعارات الفعلية
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
