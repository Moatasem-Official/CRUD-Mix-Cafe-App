import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/Order_details_screen/helper_functions.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({super.key, this.estimatedDuration, this.onTap});

  final Duration? estimatedDuration;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(IconlyLight.time_circle, color: Color(0xFF8D6E63)),
      title: Text('Preparation Time', style: GoogleFonts.poppins()),
      trailing: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Text(
            // Use the new formatter function here
            estimatedDuration != null
                ? HelperFunctions.formatDuration(estimatedDuration!)
                : 'Set Time',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              color: const Color(0xFF4E342E),
            ),
          ),
        ),
      ),
    );
  }
}
