import 'package:flutter/material.dart';

class CustomAccountThemeAppRowItem extends StatelessWidget {
  const CustomAccountThemeAppRowItem({
    super.key,
    required this.title,
    required this.index,
  });

  final String title;
  final int index;

  @override
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
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
                index == 0
                    ? Icons.dark_mode_rounded
                    : index == 1
                    ? Icons.light_mode_rounded
                    : Icons.brightness_6_rounded,
                color: const Color.fromARGB(255, 216, 165, 52),
              ),
            ),
            const SizedBox(width: 16),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  index == 0
                      ? 'Light'
                      : index == 1
                      ? 'Dark'
                      : 'No Theme',
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
        const Spacer(),
        const Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey),
      ],
    );
  }
}
