import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSwitchTile extends StatelessWidget {
  const CustomSwitchTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(
        title,
        style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        subtitle,
        style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey.shade600),
      ),
      value: value,
      onChanged: onChanged,
      activeColor: const Color(0xFFC58B3E),
      contentPadding: EdgeInsetsDirectional.zero,
    );
  }
}
