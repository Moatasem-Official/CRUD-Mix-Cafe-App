import 'package:flutter/material.dart';
import 'package:mix_cafe_app/data/model/offer_model.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/Offers_Screen/offer_card/helper_functions.dart';

class OfferStatusBadge extends StatelessWidget {
  final Offer offer;

  const OfferStatusBadge({super.key, required this.offer});

  @override
  Widget build(BuildContext context) {
    final OfferStatus status = HelperFunctions.status(offer);
    final Color iconColor = HelperFunctions.statusColor(status);
    final IconData icon = HelperFunctions.statusIcon(status);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: iconColor.withOpacity(0.1), // لون خلفية فاتح
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: iconColor.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: iconColor, size: 16),
          const SizedBox(width: 6),
          Text(
            status.name.toUpperCase(),
            style: TextStyle(
              color: iconColor,
              fontWeight: FontWeight.bold,
              fontSize: 12,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
