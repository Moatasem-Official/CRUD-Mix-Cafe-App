import 'package:flutter/material.dart';

class CustomAccountSupportRowItem extends StatelessWidget {
  const CustomAccountSupportRowItem({
    super.key,
    required this.title,
    required this.backgroundColor,
    required this.iconColor,
    required this.textColor,
    required this.icon,
  });

  final String title;
  final Color backgroundColor;
  final Color iconColor;
  final Color textColor;
  final IconData icon;

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
                color: backgroundColor,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Icon(icon, color: iconColor),
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(
                color: textColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const Spacer(),
        Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey),
      ],
    );
  }
}
