import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/custom_button.dart';

class CustomAddProductInformationForm extends StatelessWidget {
  const CustomAddProductInformationForm({
    super.key,
    required GlobalKey<FormState> formKey,
    required TextEditingController nameController,
    required TextEditingController descController,
    required TextEditingController priceController,
    required String? imageUrl,
  }) : _formKey = formKey,
       _nameController = nameController,
       _descController = descController,
       _priceController = priceController,
       _imageUrl = imageUrl;

  final GlobalKey<FormState> _formKey;
  final TextEditingController _nameController;
  final TextEditingController _descController;
  final TextEditingController _priceController;
  final String? _imageUrl;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // اسم المنتج
            Material(
              child: TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Product Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter product name'
                    : null,
              ),
            ),
            const SizedBox(height: 16),

            // وصف المنتج
            Material(
              child: TextFormField(
                controller: _descController,
                decoration: const InputDecoration(
                  labelText: 'Product description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter product description'
                    : null,
              ),
            ),
            const SizedBox(height: 16),

            // السعر
            Material(
              child: TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(
                  labelText: 'Price (EGP)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
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
            ),
            const SizedBox(height: 16),

            // اختيار الصورة (في الوقت الحالي: رابط)
            DottedBorder(
              options: RectDottedBorderOptions(
                dashPattern: [10, 5],
                strokeWidth: 2,
                color: Colors.grey,
              ),
              child: Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(8),
                child: Center(
                  child: Text(
                    _imageUrl ?? 'No Image Selected',
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // زر الإضافة
            Center(
              child: CustomButton(
                buttonText: 'Add Product',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {}
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
