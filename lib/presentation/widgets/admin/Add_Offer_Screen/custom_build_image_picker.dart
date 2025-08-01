import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mix_cafe_app/data/helpers/image_helper.dart';

class CustomBuildImagePicker extends StatelessWidget {
  const CustomBuildImagePicker({
    super.key,
    this.offerImage,
    required this.onImagePicked,
  });

  final File? offerImage;
  final Function(File image) onImagePicked;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final pickedImage = await ImageHelper.pickFromGallery();
        if (pickedImage != null) {
          onImagePicked(pickedImage);
        }
      },
      child: Container(
        height: 150,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade400, width: 1.5),
        ),
        child: offerImage != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(11),
                child: Image.file(offerImage!, fit: BoxFit.cover),
              )
            : const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_a_photo_outlined,
                    size: 40,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 8),
                  Text('اضغط هنا لاختيار صورة'),
                ],
              ),
      ),
    );
  }
}
