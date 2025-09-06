import 'package:flutter/material.dart';
import 'custom_offer_percentage.dart';
import 'custom_product_column_info.dart';
import '../../../../../constants/app_assets.dart';

class CustomProductTemplate extends StatelessWidget {
  const CustomProductTemplate({
    super.key,
    required this.productName,
    required this.productDescription,
    required this.imagePath,
    required this.productPrice,
    required this.isHasDiscount,
    required this.discountPrice,
    required this.onDelete,
    required this.onEdit,
  });

  final String productName;
  final String productDescription;
  final String imagePath;
  final double productPrice;
  final bool isHasDiscount;
  final double discountPrice;
  final Function() onDelete;
  final Function() onEdit;

  @override
  Widget build(BuildContext context) {
    double discountPercentage = 0;
    if (isHasDiscount && productPrice > 0) {
      discountPercentage =
          ((productPrice - discountPrice) / productPrice) * 100;
    }

    return Container(
      margin: const EdgeInsetsDirectional.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      padding: const EdgeInsetsDirectional.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image with Discount Ribbon
          Stack(
            clipBehavior: Clip.none,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  imagePath.isEmpty
                      ? 'https://via.placeholder.com/100'
                      : imagePath,
                  width: 100,
                  height: 120,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Image.asset(
                    Assets.mixCafeCustomerFoodImage,
                    width: 100,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              if (isHasDiscount && discountPercentage > 0)
                CustomOfferPercentage(discountPercentage: discountPercentage),
            ],
          ),
          const SizedBox(width: 16),
          CustomProductColumnInfo(
            productName: productName,
            productDescription: productDescription,
            productPrice: productPrice,
            discountPrice: discountPrice,
            isHasDiscount: isHasDiscount,
            onDelete: onDelete,
            onEdit: onEdit,
          ),
        ],
      ),
    );
  }
}
