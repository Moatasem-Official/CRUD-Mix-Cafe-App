import 'package:flutter/material.dart';

class CustomItemsTitleRow extends StatelessWidget {
  const CustomItemsTitleRow({
    super.key,
    required this.title,
    required this.onTap,
    required this.numberOfProducts,
  });

  final String title;
  final Function()? onTap;
  final int numberOfProducts;

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
              color: const Color.fromARGB(255, 165, 101, 56),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: GestureDetector(
              onTap: onTap,
              child: numberOfProducts > 5
                  ? Row(
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
                    )
                  : const Text(''),
            ),
          ),
        ],
      ),
    );
  }
}
