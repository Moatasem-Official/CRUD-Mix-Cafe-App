import 'package:flutter/material.dart';
import 'package:mix_cafe_app/data/helpers/image_helper.dart';

Future<void> showCustomImagePicBottomSheet(
  BuildContext context, {
  required void Function(String imagePath) onImageSelected,
}) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) {
      return Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Upload Image',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF8B4513),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.grey),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const Divider(),
            ListTile(
              leading: const Icon(
                Icons.image,
                size: 32,
                color: Color(0xFF8B4513),
              ),
              title: const Text(
                'Pick from Gallery',
                style: TextStyle(fontSize: 16),
              ),
              onTap: () async {
                final image = await ImageHelper.pickFromGallery();
                if (image != null) {
                  Navigator.pop(context);
                  onImageSelected(image.path);
                }
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.camera_alt,
                size: 32,
                color: Color(0xFF8B4513),
              ),
              title: const Text('Take a Photo', style: TextStyle(fontSize: 16)),
              onTap: () async {
                final image = await ImageHelper.pickFromCamera();
                if (image != null) {
                  Navigator.pop(context);
                  onImageSelected(image.path);
                }
              },
            ),
            const SizedBox(height: 12),
          ],
        ),
      );
    },
  );
}
