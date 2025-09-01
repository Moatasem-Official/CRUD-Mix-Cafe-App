import 'package:flutter/material.dart';
import '../../../../../data/model/offer_model.dart';
import 'helper_functions.dart';

class CustomOfferCardContent extends StatelessWidget {
  const CustomOfferCardContent({super.key, required this.offer});

  final Offer offer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            offer.title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Text(
            offer.description,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const Divider(height: 24, thickness: 1),
          // --- Status & Timer Row ---
          Row(
            children: [
              Icon(
                Icons.hourglass_bottom,
                color: HelperFunctions.statusColor(
                  HelperFunctions.status(offer),
                ),
                size: 20,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  HelperFunctions.timeDifferenceString(
                    HelperFunctions.status(offer),
                    offer,
                  ),
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: HelperFunctions.statusColor(
                      HelperFunctions.status(offer),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
