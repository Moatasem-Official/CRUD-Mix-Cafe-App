import 'package:flutter/material.dart';

class CustomAccountLanguageRowItem extends StatelessWidget {
  const CustomAccountLanguageRowItem({super.key, required this.title});

  final String title;

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
            Text('English', style: TextStyle(color: Colors.grey, fontSize: 16)),
            const SizedBox(width: 16),
            Text('العربية', style: TextStyle(color: Colors.grey, fontSize: 16)),
          ],
        ),
      ],
    );
  }
}
