import 'package:flutter/material.dart';

class CustomDeleteEditOfferCard extends StatelessWidget {
  const CustomDeleteEditOfferCard({
    super.key,
    required this.onDelete,
    required this.onEdit,
  });

  final Function() onDelete;
  final Function() onEdit;

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = const Color.fromARGB(255, 165, 101, 56);
    return Container(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton.icon(
            onPressed: onEdit,
            icon: Icon(Icons.edit, size: 20, color: primaryColor),
            label: Text('تعديل', style: TextStyle(color: primaryColor)),
          ),
          const SizedBox(width: 8),
          TextButton.icon(
            onPressed: onDelete,
            icon: Icon(
              Icons.delete_outline,
              size: 20,
              color: Colors.red.shade700,
            ),
            label: Text('حذف', style: TextStyle(color: Colors.red.shade700)),
          ),
        ],
      ),
    );
  }
}
