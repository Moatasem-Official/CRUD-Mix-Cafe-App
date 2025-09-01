import 'package:flutter/material.dart';
import '../../../../../data/model/offer_model.dart';

class CustomOfferImage extends StatelessWidget {
  const CustomOfferImage({super.key, required this.offer});

  final Offer offer;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      offer.imageUrl,
      height: 180,
      width: double.infinity,
      fit: BoxFit.cover,
      // Simple loading and error widgets
      loadingBuilder: (context, child, progress) => progress == null
          ? child
          : Container(
              height: 180,
              color: Colors.grey[200],
              child: const Center(child: CircularProgressIndicator()),
            ),
      errorBuilder: (context, error, stackTrace) => Container(
        height: 180,
        color: Colors.grey[200],
        child: const Icon(Icons.broken_image, size: 50, color: Colors.grey),
      ),
    );
  }
}
