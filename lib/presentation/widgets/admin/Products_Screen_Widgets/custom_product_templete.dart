import 'package:flutter/material.dart';

class CustomProductTemplate extends StatelessWidget {
  const CustomProductTemplate({
    super.key,
    required this.productName,
    required this.productDescription,
    required this.imagePath,
    required this.productPrice,
  });

  final String productName;
  final String productDescription;
  final String imagePath;
  final double productPrice;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: Card(
        color: const Color(0xFFFDF9F3), // خلفية كريمية ناعمة
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        shadowColor: Colors.brown.withOpacity(0.15),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🖼️ Product Image
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.asset(
                  imagePath,
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 90,
                    height: 90,
                    color: Colors.grey[300],
                    child: const Icon(Icons.broken_image, color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(width: 16),

              // 📝 Info Section
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
                        color: Colors.green.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.local_offer,
                            size: 18,
                            color: Colors.green,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${productPrice.toStringAsFixed(2)} EGP',
                            style: const TextStyle(
                              fontSize: 15.5,
                              color: Colors.green,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // ⚙️ Action Buttons
              Column(
                children: [
                  Tooltip(
                    message: 'Edit Product',
                    child: Material(
                      shape: const CircleBorder(),
                      color: Colors.orange.withOpacity(0.1),
                      child: IconButton(
                        icon: const Icon(Icons.edit_outlined),
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
                        icon: const Icon(Icons.delete_outline),
                        color: Colors.redAccent,
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
