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
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Card(
        elevation: 2,
        color: const Color(0xFFFDF9F3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        shadowColor: Colors.brown.withOpacity(0.1),
        child: Container(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 📷 Product Image
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
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
              const SizedBox(width: 14),

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
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF5D4037),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      productDescription,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
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
                            fontSize: 16,
                            color: Colors.green,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // 🛠️ Action Buttons
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Tooltip(
                    message: 'Delete',
                    child: IconButton(
                      icon: const Icon(Icons.delete_outline),
                      color: Colors.redAccent,
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(height: 6),
                  Tooltip(
                    message: 'Edit',
                    child: IconButton(
                      icon: const Icon(Icons.edit_outlined),
                      color: Colors.deepOrange,
                      onPressed: () {},
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
