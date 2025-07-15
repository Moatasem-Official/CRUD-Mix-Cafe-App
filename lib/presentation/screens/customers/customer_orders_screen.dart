import 'package:flutter/material.dart';
import 'package:mix_cafe_app/presentation/widgets/customer/customer_orders_screen/custom_app_bar.dart';
import 'package:mix_cafe_app/presentation/widgets/customer/customer_orders_screen/custom_order_card.dart';

class CustomerOrdersScreen extends StatelessWidget {
  const CustomerOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 253, 251),
      appBar: const CustomerOrdersAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            OrderCard(
              orderId: '1',
              date: '2023-06-01',
              status: 'Delivered',
              totalPrice: 100.00,
              products: ['Product 1', 'Product 2', 'Product 3'],
            ),
            OrderCard(
              orderId: '2',
              date: '2023-06-02',
              status: 'Pending',
              totalPrice: 50.00,
              products: ['Product 4', 'Product 5', 'Product 6'],
            ),
            OrderCard(
              orderId: '3',
              date: '2023-06-03',
              status: 'Cancelled',
              totalPrice: 75.00,
              products: ['Product 7', 'Product 8', 'Product 9'],
            ),
            OrderCard(
              orderId: '4',
              date: '2023-06-04',
              status: 'Delivered',
              totalPrice: 150.00,
              products: ['Product 10', 'Product 11', 'Product 12'],
            ),
            OrderCard(
              orderId: '5',
              date: '2023-06-05',
              status: 'Pending',
              totalPrice: 200.00,
              products: ['Product 13', 'Product 14', 'Product 15'],
            ),
            OrderCard(
              orderId: '6',
              date: '2023-06-06',
              status: 'Delivered',
              totalPrice: 300.00,
              products: ['Product 16', 'Product 17', 'Product 18'],
            ),
          ],
        ),
      ),
    );
  }
}
