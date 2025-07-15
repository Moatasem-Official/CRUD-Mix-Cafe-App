import 'package:flutter/material.dart';
import '../../../../constants/app_assets.dart';

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
  });

  final String productName;
  final String productDescription;
  final String imagePath;
  final double productPrice;
  final bool isHasDiscount;
  final double discountPrice;
  final Function() onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: Stack(
        children: [
          Card(
            color: const Color(0xFFFDF9F3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            shadowColor: Colors.brown.withOpacity(0.15),
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: FadeInImage.assetNetwork(
                      placeholder: Assets.mixCafeBeforeImageLoaded,
                      image: imagePath,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          Assets.mixCafeAdminImage,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 16),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          productName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF6E4C2B), // لون كابتشينو غامق أنيق
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          productDescription,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF8B4513).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.local_offer,
                                size: 18,
                                color: Color(0xFF8B4513),
                              ),
                              const SizedBox(width: 4),
                              isHasDiscount
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${productPrice.toStringAsFixed(2)} EGP',
                                          style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey,
                                            decoration:
                                                TextDecoration.lineThrough,
                                          ),
                                        ),
                                        Text(
                                          '${discountPrice.toStringAsFixed(2)} EGP',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF8B4513),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Text(
                                      '${productPrice.toStringAsFixed(2)} EGP',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF8B4513),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  Column(
                    children: [
                      Tooltip(
                        message: 'Edit Product',
                        child: Material(
                          shape: const CircleBorder(),
                          color: Colors.orange.withOpacity(0.1),
                          child: IconButton(
                            icon: const Icon(
                              Icons.edit_outlined,
                              color: Color(0xFF8B4513),
                            ),
                            color: Colors.deepOrange,
                            onPressed: () {},
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Tooltip(
                        message: 'Delete Product',
                        child: Material(
                          shape: const CircleBorder(),
                          color: Colors.redAccent.withOpacity(0.08),
                          child: IconButton(
                            icon: const Icon(
                              Icons.delete_outline,
                              color: Color(0xFF8B4513),
                            ),
                            color: Colors.redAccent,
                            onPressed: onDelete,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          isHasDiscount
              ? Positioned(
                  bottom: 4,
                  left: 3,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFE0B2), // لون مشرق وخفيف للأوفر
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.brown.withOpacity(0.2),
                          blurRadius: 4,
                          offset: const Offset(2, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.local_offer_rounded,
                          size: 14,
                          color: Color(0xFF8B4513),
                        ),
                        SizedBox(width: 4),
                        Text(
                          discountPrice == 0 ? 'مجاني' : 'عرض خاص',
                          style: TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF8B4513),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
