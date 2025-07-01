import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class CustomUplaodImageContainer extends StatelessWidget {
  const CustomUplaodImageContainer({super.key, this.imageUrl});
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: DottedBorder(
        options: RectDottedBorderOptions(
          dashPattern: [10, 10],
          strokeWidth: 5,
          color: const Color(0xFF8B4513),
        ),
        child: Container(
          width: double.infinity,
          height: 200,
          padding: const EdgeInsets.all(8),
          child: Center(
            child: imageUrl == null
                ? const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.image, size: 50, color: Color(0xFF8B4513)),
                      Text(
                        'Upload Product Image',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF8B4513),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                : Text(
                    imageUrl!,
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
          ),
        ),
      ),
    );
  }
}
