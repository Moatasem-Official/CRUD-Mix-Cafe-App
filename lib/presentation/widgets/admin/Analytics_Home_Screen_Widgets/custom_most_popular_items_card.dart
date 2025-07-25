import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MostPopularItemsCard extends StatelessWidget {
  const MostPopularItemsCard({
    super.key,
    required this.name,
    required this.description,
    required this.price,
    required this.imagePath,
    this.rating = 4.5,
    this.onEdit, // دالة للضغط على زر التعديل
    this.onDelete, // دالة للضغط على زر الحذف
  });

  final String name;
  final String description;
  final double price;
  final String imagePath;
  final double rating;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    // الألوان الأساسية المستخدمة في التصميم
    const Color backgroundColor = Color(0xFFF5F0E6); // لون بيج فاتح للخلفية
    const Color cardColor = Color(0xFFFFFFFF); // أبيض نقي للكارد
    const Color primaryTextColor = Color(
      0xFF6D4C41,
    ); // بني غامق للنصوص الرئيسية
    const Color secondaryTextColor = Color(
      0xFF8D6E63,
    ); // بني أفتح للنصوص الثانوية
    const Color accentColor = Color(0xFF795548); // بني للتمييز (Accent)

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

          // --- قسم المحتوى النصي ---
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: primaryTextColor,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    color: secondaryTextColor,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "$price EGP",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: accentColor,
                      ),
                    ),
                    FittedBox(
                      child: Row(
                        children: [
                          RatingBarIndicator(
                            rating: rating,
                            itemBuilder: (context, index) =>
                                const Icon(Icons.star, color: Colors.amber),
                            itemCount: 1,
                            itemSize: 18.0,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            rating.toString(),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryTextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // --- فاصل وأزرار التحكم للأدمن ---
          Divider(color: Colors.brown.shade100, height: 1, thickness: 1),

          FittedBox(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 4.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // زر التعديل
                  TextButton.icon(
                    onPressed: onEdit,
                    icon: const Icon(
                      Icons.edit_outlined,
                      size: 18,
                      color: accentColor,
                    ),
                    label: const Text(
                      'Edit',
                      style: TextStyle(
                        color: accentColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // زر الحذف
                  TextButton.icon(
                    onPressed: onDelete,
                    icon: Icon(
                      Icons.delete_outline,
                      size: 18,
                      color: Colors.red.shade700,
                    ),
                    label: Text(
                      'Delete',
                      style: TextStyle(
                        color: Colors.red.shade700,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
