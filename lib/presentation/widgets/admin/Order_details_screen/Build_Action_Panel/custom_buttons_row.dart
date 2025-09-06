import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';

class CustomButtonsRow extends StatelessWidget {
  const CustomButtonsRow({
    super.key,
    required this.onDelete,
    required this.onConfirm,
  });

  final Function() onDelete;
  final Function() onConfirm;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            icon: Icon(
              IconlyBold.delete,
              color: Color.fromARGB(255, 165, 101, 56),
              size: 20,
            ),
            label: Text(
              'Delete', // Shorter label
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 165, 101, 56),
              ),
            ),
            // ✨ This now shows a confirmation dialog ✨
            onPressed: onDelete,
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                color: Color.fromARGB(255, 165, 101, 56),
                width: 1.5,
              ),
              padding: const EdgeInsetsDirectional.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        // Confirm Button (Primary)
        Expanded(
          flex: 2, // Give more space to the primary action
          child: ElevatedButton.icon(
            icon: const Icon(IconlyBold.tick_square, size: 20),
            label: Text(
              'Confirm & Update', // Shorter label
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            ),
            onPressed: onConfirm,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4E342E),
              foregroundColor: Colors.white,
              padding: const EdgeInsetsDirectional.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
