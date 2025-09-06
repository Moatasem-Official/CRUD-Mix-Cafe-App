// 2. The Admin Offer Card Widget

import 'package:flutter/material.dart';
import 'package:mix_cafe_app/data/model/offer_model.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/Offers_Screen/offer_card/custom_delete_edit_offer_card.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/Offers_Screen/offer_card/custom_offer_card_content.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/Offers_Screen/offer_card/custom_offer_image.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/Offers_Screen/offer_card/custom_offer_status.dart';

class AdminOfferCard extends StatelessWidget {
  final Offer offer;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const AdminOfferCard({
    super.key,
    required this.offer,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.symmetric(
        vertical: 10,
        horizontal: 8,
      ),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Image Header with Badges ---
          Stack(
            children: [
              CustomOfferImage(offer: offer),
              // Status Badge
              CustomOfferStatus(offer: offer),
            ],
          ),

          // --- Content Section ---
          CustomOfferCardContent(offer: offer),

          // --- Action Buttons ---
          CustomDeleteEditOfferCard(onDelete: onDelete, onEdit: onEdit),
        ],
      ),
    );
  }
}
