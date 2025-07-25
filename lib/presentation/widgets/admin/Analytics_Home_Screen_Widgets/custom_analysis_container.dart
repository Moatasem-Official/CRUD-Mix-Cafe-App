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
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 244, 238, 236),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          children: [
            // شريط علوي صغير بلون بني غامق
            Container(
              height: 6,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 165, 101, 56),
                borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
              ),
            ),
            const SizedBox(height: 14),

            // الأيقونة داخل دائرة
            Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 165, 101, 56),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.white, size: 26),
            ),
            const SizedBox(height: 12),

            // الرقم – مع FittedBox علشان ميكسرش
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  analysisNumber,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4E342E),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 6),

            // العنوان
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 165, 101, 56),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
