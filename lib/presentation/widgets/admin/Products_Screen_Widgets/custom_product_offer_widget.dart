import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: DottedBorder(
            options: RectDottedBorderOptions(
              dashPattern: [10, 6],
              strokeWidth: 5,
              color: const Color(0xFFB6855E),
            ),
            child: Container(
              width: double.infinity,
              height: 180,
              color: const Color(0xFFFDF9F6),
              child: Center(
                child: offerImageUrl == null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.image_outlined,
                            size: 50,
                            color: Color(0xFFB6855E),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Upload Offer Image',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFFB6855E),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text(
                          offerImageUrl!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),

        const Text(
          "Offer Price",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Color(0xFFB6855E),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: offerController,
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
          decoration: InputDecoration(
            hintText: 'e.g. 39.99',
            filled: true,
            fillColor: Colors.white,
            prefixIcon: const Icon(Icons.local_offer, color: Color(0xFF6F4E37)),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.brown),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }
}
