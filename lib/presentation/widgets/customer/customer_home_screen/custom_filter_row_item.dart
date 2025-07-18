import 'package:flutter/material.dart';

class CustomFilterRowItem extends StatelessWidget {
  const CustomFilterRowItem({
    super.key,
    required this.filterName,
    required this.filterIcon,
    this.filterId,
    this.isSelected = false,
    this.onTap,
  });

  final String filterName;
  final IconData filterIcon;
  final int? filterId;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 250),
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color.fromARGB(255, 244, 206, 134)
              : Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(filterIcon, color: Colors.orange, size: 20),
            const SizedBox(width: 8),
            Text(
              filterName,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
