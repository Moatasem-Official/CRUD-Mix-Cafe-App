import 'package:flutter/material.dart';

class CustomFilterRowItem extends StatelessWidget {
  const CustomFilterRowItem({
    super.key,
    required this.filterName,
    required this.filterIcon,
  });

  final String filterName;
  final IconData filterIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(filterIcon, color: Colors.orange),
          SizedBox(width: 8),
          Text(filterName, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
