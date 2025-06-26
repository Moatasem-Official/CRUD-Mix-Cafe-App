import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/custom_add_product_info_form.dart';

class CustomWidgetIfProductHasOffer extends StatelessWidget {
  const CustomWidgetIfProductHasOffer({
    super.key,
    required this.offerImageUrl,
    required this.offerController,
  });

  final dynamic offerImageUrl;
  final TextEditingController offerController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: DottedBorder(
            options: RectDottedBorderOptions(
              dashPattern: [10, 10],
              strokeWidth: 5,
              color: Colors.grey,
            ),
            child: Container(
              width: double.infinity,
              height: 200,
              padding: const EdgeInsets.all(8),
              child: Center(
                child: offerImageUrl == null
                    ? const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.image, size: 50, color: Color(0xFF6F4E37)),
                          Text(
                            'Upload Offer Image',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF6F4E37),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                    : Text(
                        offerImageUrl,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Material(
          child: TextFormField(
            controller: offerController,
            decoration: const InputDecoration(
              labelText: 'Offer Price (EGP)',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Enter Offer Price';
              }
              if (double.tryParse(value) == null) {
                return 'Enter Valid Offer Price';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
