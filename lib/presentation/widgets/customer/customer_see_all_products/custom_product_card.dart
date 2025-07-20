import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:mix_cafe_app/data/model/product_model.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String description;
  final double price;
  final double discountPercentage;
  final int quantity;
  final bool isAvailable;
  final bool hasDiscount;
  final DateTime? offerStartDate;
  final DateTime? offerEndDate;
  final Function()? onAddToCart;
  final ProductModel product;

  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.quantity,
    required this.isAvailable,
    required this.hasDiscount,
    this.offerStartDate,
    this.offerEndDate,
    this.onAddToCart,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final discountedPrice = price - (price * discountPercentage / 100);

    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        '/customerShowProductDetails',
        arguments: product,
      ),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.08),
              blurRadius: 6,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // صورة المنتج
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imageUrl,
                width: 90,
                height: 90,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),

            // التفاصيل
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // الاسم + الخصم
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      if (hasDiscount && discountPercentage > 0)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.orange.shade100,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '${discountPercentage.toInt()}% OFF',
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepOrange,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),

                  // الوصف
                  Text(
                    description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 6),

                  // السعر + الكمية
                  Row(
                    children: [
                      const Icon(IconlyLight.wallet, size: 16),
                      const SizedBox(width: 4),
                      if (hasDiscount && discountPercentage > 0)
                        Row(
                          children: [
                            Text(
                              'EGP ${price.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              discountedPrice <= 0
                                  ? 'Free'
                                  : 'EGP ${discountedPrice.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.brown,
                              ),
                            ),
                          ],
                        )
                      else
                        Text(
                          price <= 0
                              ? 'Free'
                              : 'EGP ${price.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.brown,
                          ),
                        ),
                      const SizedBox(width: 12),
                      const Icon(IconlyLight.bag, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        '$quantity pcs',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  // حالة التوفر
                  Row(
                    children: [
                      Icon(
                        isAvailable
                            ? Icons.check_circle_outline
                            : Icons.remove_circle_outline,
                        size: 16,
                        color: isAvailable ? Colors.green : Colors.red,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        isAvailable ? 'Available' : 'Out of Stock',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: isAvailable ? Colors.green : Colors.red,
                        ),
                      ),
                    ],
                  ),

                  // تاريخ العرض (لو موجود)
                  if (hasDiscount &&
                      offerStartDate != null &&
                      offerEndDate != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        'Offer: ${_formatDate(offerStartDate!)} - ${_formatDate(offerEndDate!)}',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: Colors.orange,
                        ),
                      ),
                    ),

                  // زر الإضافة
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: isAvailable ? onAddToCart : null,
                      icon: const Icon(Icons.shopping_cart_outlined),
                      color: isAvailable ? Colors.brown[400] : Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String _formatDate(DateTime date) {
  return '${date.day}/${date.month}/${date.year}';
}
