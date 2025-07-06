import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/Products_Screen_Widgets/custom_imagepic_bottomsheet.dart';

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
            ? Image.network(
                imageUrl!,
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
                  padding: const EdgeInsets.all(8),
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
