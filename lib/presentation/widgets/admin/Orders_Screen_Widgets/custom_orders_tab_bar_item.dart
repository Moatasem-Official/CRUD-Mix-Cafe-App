import 'package:flutter/material.dart';

class CustomOrdersTabBarItem extends StatelessWidget {
  const CustomOrdersTabBarItem({
    super.key,
    required this.itemText,
    required this.onTap,
    required this.isSelected,
  });

  final String itemText;
  final VoidCallback onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 120,
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected
              ? const Color.fromARGB(255, 165, 101, 56)
              : const Color(0xFFF9F9F9),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 0, 8, 0),
          child: Text(
            itemText,
            style: TextStyle(
              color: isSelected ? Colors.white : const Color(0xFF6F4E37),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
