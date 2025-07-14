import 'package:flutter/material.dart';

class CustomItemsTitleRow extends StatelessWidget {
  const CustomItemsTitleRow({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 193, 132, 0),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: [
                const Text(
                  'See All',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 193, 132, 0),
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Color.fromARGB(255, 193, 132, 0),
                  size: 18,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
