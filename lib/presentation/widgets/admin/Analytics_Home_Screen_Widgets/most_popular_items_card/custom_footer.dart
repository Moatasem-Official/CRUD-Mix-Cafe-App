import 'package:flutter/material.dart';

class CustomFooter extends StatelessWidget {
  const CustomFooter({
    super.key,
    required this.onEdit,
    required this.onDelete,
    required this.accentColor,
  });

  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton.icon(
              onPressed: onEdit,
              icon: Icon(Icons.edit_outlined, size: 18, color: accentColor),
              label: Text(
                'Edit',
                style: TextStyle(
                  color: accentColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(width: 8),
            TextButton.icon(
              onPressed: onDelete,
              icon: Icon(
                Icons.delete_outline,
                size: 18,
                color: Colors.red.shade700,
              ),
              label: Text(
                'Delete',
                style: TextStyle(
                  color: Colors.red.shade700,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
