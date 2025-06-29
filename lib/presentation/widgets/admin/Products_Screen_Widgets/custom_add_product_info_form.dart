import 'package:flutter/material.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/custom_button.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/Products_Screen_Widgets/custom_product_offer_widget.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/Products_Screen_Widgets/custom_upload_image_container.dart';

class CustomAddProductInformationForm extends StatefulWidget {
  CustomAddProductInformationForm({
    super.key,
    required GlobalKey<FormState> formKey,
    required TextEditingController nameController,
    required TextEditingController descController,
    required TextEditingController priceController,
    required TextEditingController offerPriceController,
    required String? imageUrl,
    this.offerImageUrl,
    this.isHasOffer = false,
  }) : _formKey = formKey,
       _nameController = nameController,
       _descController = descController,
       _priceController = priceController,
       _offerPriceController = offerPriceController,
       _imageUrl = imageUrl;

  final GlobalKey<FormState> _formKey;
  final TextEditingController _nameController;
  final TextEditingController _descController;
  final TextEditingController _priceController;
  final TextEditingController _offerPriceController;
  final String? _imageUrl;
  bool isHasOffer = false;
  final String? offerImageUrl;

  @override
  State<CustomAddProductInformationForm> createState() =>
      _CustomAddProductInformationFormState();
}

class _CustomAddProductInformationFormState
    extends State<CustomAddProductInformationForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget._formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // اسم المنتج
            Material(
              child: TextFormField(
                controller: widget._nameController,
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
                controller: widget._descController,
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
                controller: widget._priceController,
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
            CustomUplaodImageContainer(imageUrl: widget._imageUrl),
            const SizedBox(height: 16),
            Row(
              spacing: 8,
              children: [
                Switch(
                  activeColor: Color.fromARGB(255, 165, 101, 56),
                  inactiveThumbColor: Color.fromARGB(255, 177, 133, 102),
                  inactiveTrackColor: Color.fromARGB(255, 200, 180, 166),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  trackOutlineColor: WidgetStateProperty.all(
                    Color.fromARGB(255, 200, 180, 166),
                  ),
                  value: widget.isHasOffer,
                  onChanged: (value) {
                    setState(() {
                      widget.isHasOffer = value;
                    });
                  },
                ),
                const Text(
                  'Product Has Offer ?',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF6F4E37),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // صورة العرض (في الوقت الحالي: رابط)
            if (widget.isHasOffer)
              CustomWidgetIfProductHasOffer(
                offerImageUrl: widget.offerImageUrl,
                offerController: widget._offerPriceController,
              ),

            const SizedBox(height: 24),

            // زر الإضافة
            Center(
              child: CustomButton(
                buttonText: 'Add Product',
                onPressed: () {
                  if (widget._formKey.currentState!.validate()) {}
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
