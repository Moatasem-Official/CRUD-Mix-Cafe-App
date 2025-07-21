import 'package:flutter/material.dart';
import 'package:mix_cafe_app/presentation/widgets/customer/customer_orders_screen/custom_app_bar.dart';
import 'package:mix_cafe_app/presentation/widgets/customer/customer_orders_screen/custom_order_card.dart';

class CustomerOrdersScreen extends StatelessWidget {
  const CustomerOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 253, 251),
      body: CustomScrollView(
        slivers: [
          // 1. Your new "fantastic" SliverAppBar
          const CustomerOrdersSliverAppBar(),

          const SliverToBoxAdapter(child: SizedBox(height: 20)),
          // 2. The list of orders
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                // Here you build your OrderCard
                return OrderCard(
                  // Pass your order data here
                  orderId: '1025${index + 1}',
                  date: 'July 21, 2025',
                  status: ['Pending', 'Delivered', 'Cancelled'][index % 3],
                  totalPrice: 125.50 + (index * 10),
                  products: const ['Espresso', 'Croissant', 'Latte'],
                );
              },
              childCount: 15, // Example count
            ),
          ),
        ],
      ),
    );
  }
}
