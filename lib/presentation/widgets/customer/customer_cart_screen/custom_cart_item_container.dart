import 'package:flutter/material.dart';
import '../../../../constants/app_assets.dart';

class CustomCartItemContainer extends StatelessWidget {
  const CustomCartItemContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              Assets.mixCafeCustomerFoodImage, // استخدم صورة حقيقية إن أردت
              height: 50,
              width: 50,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Kofta Burger',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'EGP 30.00',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF9C6B1C), // لون قريب من الصورة
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF3EFEA), // لون بيج فاتح
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(Icons.remove, size: 18),
                  onPressed: () {
                    // decrease quantity
                  },
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                '1',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(width: 8),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF3EFEA), // لون بيج فاتح
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(Icons.add, size: 18),
                  onPressed: () {
                    // Increase quantity
                  },
                ),
              ),
            ],
          ),
          const SizedBox(width: 10),
          IconButton(
            onPressed: () {
              // Remove item
            },
            icon: const Icon(Icons.delete_outline),
            color: Colors.grey[600],
          ),
        ],
      ),
    );
  }
}
