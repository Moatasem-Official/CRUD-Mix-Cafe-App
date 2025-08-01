import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImageHelper {
  static final ImagePicker _picker = ImagePicker();

  static Future<File?> pickFromGallery() async {
    final picked = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
      maxWidth: 1024,
      maxHeight: 1024,
    );
    return picked != null ? File(picked.path) : null;
  }

  static Future<File?> pickFromCamera() async {
    final picked = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 100,
      maxWidth: 1024,
      maxHeight: 1024,
    );
    return picked != null ? File(picked.path) : null;
  }
}
