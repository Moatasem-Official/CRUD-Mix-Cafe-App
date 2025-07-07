import 'package:flutter/material.dart';
import 'custom_styled_field.dart';
import '../custom_upload_image_container.dart';

class WithoutDiscountWidget extends StatelessWidget {
  const WithoutDiscountWidget({
    super.key,
    required this.nameController,
    required this.descController,
    required this.priceController,
    required this.quantityController,
    this.imageUrl,
    this.onImageSelected,
  });

  final TextEditingController nameController;
  final TextEditingController descController;
  final TextEditingController priceController;
  final TextEditingController quantityController;
  final String? imageUrl; // في الوقت الحالي نعتبر الصورة رابط
  final Function(String)? onImageSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Add New Product",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF8B4513),
          ),
        ),
        const SizedBox(height: 20),

        // اسم المنتج
        CustomStyledField(
          controller: nameController,
          label: 'Product Name',
          validatorMessage: 'Please enter product name',
          keyboardType: TextInputType.text,
          maxLines: 1,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter product name';
            }
            return null;
          },
        ),

        // وصف المنتج
        CustomStyledField(
          controller: descController,
          label: 'Product Description',
          maxLines: 3,
          validatorMessage: 'Please enter product description',
          keyboardType: TextInputType.multiline,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter product description';
            }
            return null;
          },
        ),

        // السعر
        CustomStyledField(
          controller: priceController,
          label: 'Price (EGP)',
          keyboardType: TextInputType.number,
          maxLines: 1,
          validatorMessage: 'Enter Price',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Enter Price';
            }
            if (double.tryParse(value) == null) {
              return 'Enter Valid Price';
            }
            return null;
          },
        ),

        CustomStyledField(
          controller: quantityController,
          label: 'Quantity',
          keyboardType: TextInputType.number,
          validatorMessage: 'Please enter product quantity',
          maxLines: 1,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter product quantity';
            }
            if (int.tryParse(value) == null || int.parse(value) <= 0) {
              return 'Enter a valid quantity';
            }
            return null;
          },
        ),

        const SizedBox(height: 16),

        // تحميل صورة المنتج
        const Text(
          "Upload Product Image",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Color(0xFF8B4513),
          ),
        ),
        const SizedBox(height: 8),
        CustomUplaodImageContainer(
          imageUrl: imageUrl,
          onImageSelected: onImageSelected,
        ),
      ],
    );
  }
}
