import 'package:flutter/material.dart';

class CustomAnalysisContainer extends StatelessWidget {
  const CustomAnalysisContainer({
    super.key,
    required this.title,
    required this.analysisNumber,
    required this.icon,
  });

  final String title;
  final String analysisNumber;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 170,
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFEFEBE9),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFD7CCC8), width: 1.2),
          boxShadow: [
            BoxShadow(
              color: Colors.brown.withOpacity(0.15),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            // شريط علوي صغير بلون بني غامق
            Container(
              height: 6,
              decoration: const BoxDecoration(
                color: Color(0xFF6F4E37),
                borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
              ),
            ),
            const SizedBox(height: 14),

            // الأيقونة داخل دائرة
            Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                color: Color(0xFF6F4E37),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.white, size: 26),
            ),
            const SizedBox(height: 12),

            // الرقم
            Text(
              analysisNumber,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4E342E),
              ),
            ),
            const SizedBox(height: 6),

            // العنوان
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF5D4037),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
