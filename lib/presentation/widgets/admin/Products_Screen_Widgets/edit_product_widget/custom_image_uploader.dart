import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconly/iconly.dart';
import 'package:mix_cafe_app/data/helpers/image_helper.dart';
import 'package:mix_cafe_app/data/services/cloudinary/cloudinary_services.dart';
import '../../../../../data/model/product_model.dart';

class CustomImageUploader extends StatefulWidget {
  const CustomImageUploader({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  State<CustomImageUploader> createState() => _CustomImageUploaderState();
}

class _CustomImageUploaderState extends State<CustomImageUploader> {
  late String imageUrl;

  @override
  void initState() {
    super.initState();
    imageUrl = widget.productModel.imageUrl;
  }

  void _pickAndUploadImage() async {
    final image = await ImageHelper.pickFromGallery();
    if (image != null) {
      final cloudinary = CloudinaryServices();
      final uploadedUrl = await cloudinary.uploadImageToCloudinary(image);
      if (uploadedUrl != null) {
        setState(() {
          imageUrl = uploadedUrl;
          widget.productModel.imageUrl = uploadedUrl; // Keep model in sync
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(
                    color: const Color(0xFFC58B3E).withOpacity(0.5),
                    width: 3,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFC58B3E),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: IconButton(
                    onPressed: _pickAndUploadImage,
                    icon: const Icon(
                      IconlyBold.camera,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
        .animate()
        .slideY(begin: 0.5, duration: 600.ms, curve: Curves.easeOutCubic)
        .fadeIn();
  }
}
