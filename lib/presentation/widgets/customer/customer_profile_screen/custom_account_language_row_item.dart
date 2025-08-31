import 'package:flutter/material.dart';

class CustomAccountLanguageRowItem extends StatelessWidget {
  const CustomAccountLanguageRowItem({
    super.key,
    required this.title,
    required this.selectedLanguage,
    required this.index,
    required this.onArabicTap,
    required this.onEnglishTap,
  });

  final String title;
  final String selectedLanguage;
  final int index;
  final VoidCallback onArabicTap;
  final VoidCallback onEnglishTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 225, 225, 225),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Icon(
                Icons.translate_rounded,
                color: const Color.fromARGB(255, 216, 165, 52),
              ),
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const Spacer(),
        Row(
          children: [
            GestureDetector(
              onTap: onEnglishTap,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: selectedLanguage == 'en'
                      ? const Color(0xFFC58B3E)
                      : Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Text(
                  'English',
                  style: TextStyle(
                    color: selectedLanguage == 'en'
                        ? Colors.white
                        : Colors.grey,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            GestureDetector(
              onTap: onArabicTap,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: selectedLanguage == 'ar'
                      ? const Color(0xFFC58B3E)
                      : Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Text(
                  'العربية',
                  style: TextStyle(
                    color: selectedLanguage == 'ar'
                        ? Colors.white
                        : Colors.grey,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
