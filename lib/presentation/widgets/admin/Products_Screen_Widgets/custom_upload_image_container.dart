import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'custom_imagepic_bottomsheet.dart';

class CustomUplaodImageContainer extends StatelessWidget {
  final String? imageUrl;
  final void Function(String imagePath)? onImageSelected;

  const CustomUplaodImageContainer({
    super.key,
    this.imageUrl,
    this.onImageSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showCustomImagePicBottomSheet(
          context,
          onImageSelected: onImageSelected!,
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: imageUrl != null
            ? Image.file(
                File(imageUrl!),
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              )
            : DottedBorder(
                options: RectDottedBorderOptions(
                  dashPattern: [10, 10],
                  strokeWidth: 5,
                  color: const Color(0xFF8B4513),
                ),
                child: Container(
                  width: double.infinity,
                  height: 200,
                  padding: const EdgeInsetsDirectional.all(8),
                  child: Center(
                    child: const Column(
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
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
