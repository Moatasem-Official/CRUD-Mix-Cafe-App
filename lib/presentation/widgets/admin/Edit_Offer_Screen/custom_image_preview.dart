import 'dart:io';

import 'package:flutter/material.dart';
import '../../../../data/model/offer_model.dart';

class CustomImagePreview extends StatelessWidget {
  const CustomImagePreview({super.key, this.image, required this.offer});

  final File? image;
  final Offer offer;

  @override
  Widget build(BuildContext context) {
    if (image != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.file(File(image!.path), height: 150, fit: BoxFit.cover),
      );
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(offer.imageUrl, height: 150, fit: BoxFit.cover),
      );
    }
  }
}
