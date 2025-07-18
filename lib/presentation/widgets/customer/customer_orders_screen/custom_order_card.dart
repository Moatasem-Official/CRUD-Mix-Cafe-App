import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {
  final String orderId;
  final String date;
  final String status;
  final double totalPrice;
  final List<String> products;

  const OrderCard({
    super.key,
    required this.orderId,
    required this.date,
    required this.status,
    required this.totalPrice,
    required this.products,
  });

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'delivered':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🧾 Order ID + Date
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Order #$orderId',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.brown,
                ),
              ),
              Text(
                date,
                style: const TextStyle(fontSize: 13, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // 🛍️ Products List (names or icons)
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: products.map((product) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F4F2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  product,
                  style: const TextStyle(fontSize: 13, color: Colors.black87),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 12),

          // 💲 Total + Status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total: \$${totalPrice.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: getStatusColor(status).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: getStatusColor(status),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // 🔁 Reorder & View Details
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFF7F4F2), // خلفية فاتحة خفيفة
              borderRadius: BorderRadius.circular(12),
            ),
            child: MaterialButton(
              onPressed: () {},
              color: const Color(0xFFC58B3E), // بني
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12), // تقليل الـ radius
              ),
              padding: const EdgeInsets.symmetric(vertical: 14),
              elevation: 0, // بدون ظل
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.replay, color: Colors.white, size: 18),
                  const SizedBox(width: 8),
                  const Text(
                    'Reorder',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
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
