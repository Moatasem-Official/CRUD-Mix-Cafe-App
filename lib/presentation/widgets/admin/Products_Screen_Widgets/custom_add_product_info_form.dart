import 'package:flutter/material.dart';
import 'custom_product_offer_widget.dart';
import 'custom_upload_image_container.dart';

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
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            _buildStyledField(
              controller: widget._nameController,
              label: 'Product Name',
              validatorMessage: 'Please enter product name',
            ),

            // وصف المنتج
            _buildStyledField(
              controller: widget._descController,
              label: 'Product Description',
              maxLines: 3,
              validatorMessage: 'Please enter product description',
            ),

            // السعر
            _buildStyledField(
              controller: widget._priceController,
              label: 'Price (EGP)',
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
            CustomUplaodImageContainer(imageUrl: widget._imageUrl),

            const SizedBox(height: 20),

            // Switch العرض
            Row(
              children: [
                Switch(
                  value: widget.isHasOffer,
                  onChanged: (value) {
                    setState(() => widget.isHasOffer = value);
                  },
                  activeColor: const Color(0xFF8B5E3C), // بني غني
                  inactiveThumbColor: const Color(0xFFD7B899), // بيج ناعم
                  inactiveTrackColor: const Color(
                    0xFFF3E3D3,
                  ), // بيج أفتح لمسار التراك
                  trackOutlineColor: WidgetStateProperty.all(
                    const Color(0xFFDCC6B1), // تحديد بسيط للمسار
                  ),
                  splashRadius: 20,
                ),
                const SizedBox(width: 8),
                const Text(
                  "Has Offer ?",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF8B4513),
                  ),
                ),
              ],
            ),
            // تفاصيل العرض
            if (widget.isHasOffer) ...[
              const SizedBox(height: 16),
              const Text(
                "Offer Details",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Color(0xFF8B4513),
                ),
              ),
              const SizedBox(height: 8),
              CustomWidgetIfProductHasOffer(
                offerImageUrl: widget.offerImageUrl,
                offerController: widget._offerPriceController,
              ),
            ],

            const SizedBox(height: 28),

            // زر إضافة المنتج
            Center(
              child: FilledButton.icon(
                onPressed: () {
                  if (widget._formKey.currentState!.validate()) {
                    // Logic Here
                  }
                },
                icon: const Icon(Icons.add_circle_outline),
                label: const Text("Add Product"),
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF8B4513),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildStyledField({
  required TextEditingController controller,
  required String label,
  int maxLines = 1,
  TextInputType keyboardType = TextInputType.text,
  String? Function(String?)? validator,
  String? validatorMessage,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator:
          validator ??
          (value) => value == null || value.isEmpty ? validatorMessage : null,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        labelStyle: const TextStyle(color: Color(0xFF8B4513)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFF8B4513)),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
  );
}
