import 'package:flutter/material.dart';
import '../../../../../data/model/offer_model.dart';
import 'helper_functions.dart';

class CustomOfferStatus extends StatelessWidget {
  const CustomOfferStatus({super.key, required this.offer});

  final Offer offer;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 12,
      left: 12,
      child: Chip(
        avatar: Icon(
          HelperFunctions.statusIcon(HelperFunctions.status(offer)),
          color: Colors.white,
          size: 18,
        ),
        label: Text(
          HelperFunctions.status(offer).name.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
        backgroundColor: HelperFunctions.statusColor(
          HelperFunctions.status(offer),
        ),
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: 8,
          vertical: 4,
        ),
      ),
    );
  }
}
