import 'package:flutter/material.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/custom_order_container.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/custom_orders_drop_menu_item.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/custom_orders_screen_appbar.dart';

class OrdersManagmentScreen extends StatefulWidget {
  const OrdersManagmentScreen({super.key});

  @override
  State<OrdersManagmentScreen> createState() => _OrdersManagmentScreenState();
}

class _OrdersManagmentScreenState extends State<OrdersManagmentScreen> {
  List orders = [
    {"id": 1, "name": "John Doe", "date": "2023-05-01", "status": "Pending"},
    {
      "id": 2,
      "name": "Jane Smith",
      "date": "2023-05-02",
      "status": "Delivered",
    },
    {
      "id": 3,
      "name": "Bob Johnson",
      "date": "2023-05-03",
      "status": "In Progress",
    },
    {"id": 4, "name": "Alice Brown", "date": "2023-05-04", "status": "Pending"},
    {
      "id": 5,
      "name": "Charlie Davis",
      "date": "2023-05-05",
      "status": "Delivered",
    },
    {
      "id": 6,
      "name": "Eve Wilson",
      "date": "2023-05-06",
      "status": "In Progress",
    },
    {
      "id": 7,
      "name": "Frank Thompson",
      "date": "2023-05-07",
      "status": "Pending",
    },
    {
      "id": 8,
      "name": "Grace Martinez",
      "date": "2023-05-08",
      "status": "Delivered",
    },
    {
      "id": 9,
      "name": "Hank Jackson",
      "date": "2023-05-09",
      "status": "In Progress",
    },
    {
      "id": 10,
      "name": "Ivy Anderson",
      "date": "2023-05-10",
      "status": "Pending",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      appBar: CustomOrdersManagmentAppBar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: orders.length,
              itemBuilder: (context, index) {
                return CustomOrderContainerTemplete(
                  orderId: orders[index]['id'].toString(),
                  customerName: orders[index]['name'],
                  date: orders[index]['date'],
                  status: orders[index]['status'],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
