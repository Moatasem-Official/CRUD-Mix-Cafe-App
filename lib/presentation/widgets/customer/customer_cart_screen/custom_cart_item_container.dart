import 'package:flutter/material.dart';
import '../../../../data/model/product_model.dart';

class CustomCartItemContainer extends StatelessWidget {
  const CustomCartItemContainer({
    super.key,
    required this.productName,
    required this.productPrice,
    required this.productImage,
    required this.productQuantity,
    required this.onDelete,
    required this.onAdd,
    required this.onMinus,
    this.product,
  });

  final ProductModel? product;
  final String productName;
  final double productPrice;
  final int productQuantity;
  final String productImage;
  final Function() onDelete;
  final Function() onAdd;
  final Function() onMinus;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => Navigator.pushNamed(
        context,
        '/customerShowProductDetails',
        arguments: product,
      ),
      child: Container(
        margin: const EdgeInsetsDirectional.symmetric(
          vertical: 8,
          horizontal: 4,
        ),
        padding: const EdgeInsetsDirectional.all(12),
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
              child: Image.network(
                productImage,
                height: 50,
                width: 50,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productName,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    productPrice == 0
                        ? 'Free'
                        : 'EGP ${productPrice.toStringAsFixed(2)}',
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
                    onPressed: onMinus,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  productQuantity.toString(),
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
                    onPressed: onAdd,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 10),
            IconButton(
              onPressed: onDelete,
              icon: const Icon(Icons.delete_outline),
              color: Colors.grey[600],
            ),
          ],
        ),
      ),
    );
  }
}
