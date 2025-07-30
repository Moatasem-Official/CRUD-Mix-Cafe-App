import 'package:flutter/material.dart';
import 'custom_text_content.dart';

class MostPopularItemsCard extends StatelessWidget {
  const MostPopularItemsCard({
    super.key,
    required this.name,
    required this.description,
    required this.price,
    required this.imagePath,
    this.rating = 4.5,
  });

  final String name;
  final String description;
  final double price;
  final String imagePath;
  final double rating;

  @override
  Widget build(BuildContext context) {
    const Color backgroundColor = Color(0xFFF5F0E6);
    const Color cardColor = Color(0xFFFFFFFF);
    const Color primaryTextColor = Color(0xFF6D4C41);
    const Color secondaryTextColor = Color(0xFF8D6E63);
    const Color accentColor = Color(0xFF795548);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.brown.shade100, width: 1), // إطار خفيف
        boxShadow: [
          BoxShadow(
            color: Colors.brown.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- قسم الصورة ---
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(
              imagePath,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 180,
                color: backgroundColor,
                child: const Icon(
                  Icons.image_not_supported_outlined,
                  color: secondaryTextColor,
                  size: 40,
                ),
              ),
            ),
          ),

          CustomTextContent(
            name: name,
            description: description,
            price: price,
            rating: rating,
            accentColor: accentColor,
            primaryTextColor: primaryTextColor,
            secondaryTextColor: secondaryTextColor,
          ),
        ],
      ),
    );
  }
}
