import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:lottie/lottie.dart';
import 'package:mix_cafe_app/data/model/product_model.dart';

class CustomProductContainer extends StatelessWidget {
  const CustomProductContainer({
    super.key,
    required this.productImage,
    required this.productName,
    required this.productPrice,
    this.discountPercentage = 0,
    this.quantity = 0,
    this.isAvailable = true,
    this.onAddToCart,
    this.onTap,
    this.offerStartDate,
    this.offerEndDate,
    required this.hasDiscount,
    required this.product,
  });

  final String productImage;
  final String productName;
  final double productPrice;
  final double discountPercentage;
  final int quantity;
  final bool isAvailable;
  final bool hasDiscount;
  final ProductModel product;
  final Function(ProductModel product)? onAddToCart;
  final Function()? onTap;
  final DateTime? offerStartDate;
  final DateTime? offerEndDate;

  @override
  Widget build(BuildContext context) {
    final discountedPrice =
        productPrice - (productPrice * discountPercentage / 100);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        height: 315,
        width: 190,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF8F0),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // صورة المنتج
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  child: Image.network(
                    productImage,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 120,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return SizedBox(
                        width: double.infinity,
                        height: 120,
                        child: Lottie.asset(
                          'assets/animations/Animation - 1751639954708.json',
                        ),
                      );
                    },
                  ),
                ),
                if (hasDiscount && discountPercentage > 0)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.deepOrange.shade300,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            IconlyBold.discount,
                            size: 12,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '$discountPercentage% OFF',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 10),

            // الاسم
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                productName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF4E342E),
                ),
              ),
            ),
            const SizedBox(height: 8),

            // السعر + الكمية
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  const Icon(
                    IconlyLight.wallet,
                    size: 16,
                    color: Color(0xFF795548),
                  ),
                  const SizedBox(width: 4),

                  // السعر
                  if (hasDiscount && discountPercentage > 0)
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            'EGP ${productPrice.toStringAsFixed(2)}',
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
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFC58B3E),
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    Expanded(
                      child: Text(
                        productPrice <= 0
                            ? 'Free'
                            : 'EGP ${productPrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFC58B3E),
                        ),
                      ),
                    ),

                  const SizedBox(width: 4),
                  const Icon(
                    IconlyLight.bag,
                    size: 16,
                    color: Color(0xFF8D6E63),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '$quantity pcs',
                    style: const TextStyle(fontSize: 13, color: Colors.black54),
                  ),
                ],
              ),
            ),

            // تاريخ العرض
            if (hasDiscount &&
                discountPercentage > 0 &&
                offerStartDate != null &&
                offerEndDate != null)
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 4),
                child: Text(
                  'Offer: ${_formatDate(offerStartDate!)} - ${_formatDate(offerEndDate!)}',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: Colors.orange,
                  ),
                ),
              ),

            const SizedBox(height: 4),

            // حالة التوفر
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
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
            ),
            const Spacer(),

            // زر الإضافة للسلة
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => isAvailable ? onAddToCart!(product) : null,
                  icon: const Icon(Icons.shopping_cart_outlined, size: 18),
                  label: const Text('Add'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isAvailable
                        ? const Color(0xFFC58B3E)
                        : Colors.grey,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                ),
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
