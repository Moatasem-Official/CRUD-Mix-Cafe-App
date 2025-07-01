import 'package:flutter/material.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/Orders_Screen_Widgets/confirm_order_button.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/Orders_Screen_Widgets/custom_order_total_price_container.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/Orders_Screen_Widgets/custom_orders_app_bar.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/Orders_Screen_Widgets/customer_details_card.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/Orders_Screen_Widgets/delete_order_button.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/Orders_Screen_Widgets/order_information_card.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/Orders_Screen_Widgets/order_preparation_time.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/Orders_Screen_Widgets/order_products.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/Orders_Screen_Widgets/save_order_preparation_time_button.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/Orders_Screen_Widgets/update_order_status_dropdown.dart';

class AdminOrderDetailsScreen extends StatefulWidget {
  const AdminOrderDetailsScreen({super.key});

  @override
  State<AdminOrderDetailsScreen> createState() =>
      _AdminOrderDetailsScreenState();
}

class _AdminOrderDetailsScreenState extends State<AdminOrderDetailsScreen> {
  String orderStatus = "Delivered";

  final List<String> statusOptions = [
    'Pending',
    'Preparing',
    'On the Way',
    'Delivered',
    'Cancelled',
  ];

  TimeOfDay? estimatedDuration;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomOrdersAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Order Info
            OrderInformationCard(
              cardTitle: "Order Details",
              cardFirstRowValue: "Order ID: #123456",
              cardSecondRowValue: "Order Date: 2023-08-15",
              cardThirdRowValue: "Order Status: ",
              orderStatus: orderStatus,
            ),
            const SizedBox(height: 16),
            // Customer Info
            CustomerDetailsCard(
              cardTitle: "Customer Information",
              cardFirstRowValue: "Name: John Doe",
              cardSecondRowValue: "Phone: 123-456-7890",
              cardThirdRowValue: "Address: 123 Main St, Anytown, USA",
            ),
            const SizedBox(height: 16),
            // Products List
            const Text(
              "Products",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.brown,
              ),
            ),
            const SizedBox(height: 12),
            OrderProducts(name: "Cappuccino", quantity: 2, price: 40),
            OrderProducts(name: "Latte", quantity: 3, price: 30),
            OrderProducts(name: "Espresso", quantity: 1, price: 20),
            const Divider(height: 32),
            // Total
            CustomOrderTotalPriceContainer(totalPrice: "120.00"),
            const SizedBox(height: 32),
            // Dropdown + Action Buttons
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                OrderPreparationTime(
                  estimatedDuration: estimatedDuration,
                  onTimePicked: (pickedTime) {
                    setState(() {
                      estimatedDuration = pickedTime;
                    });
                  },
                ),
                const SizedBox(height: 16),
                UpdateOrderStatusDropdown(
                  statusOptions: statusOptions,
                  orderStatus: orderStatus,
                  onStatusChanged: (newStatus) {
                    setState(() {
                      orderStatus = newStatus!;
                    });
                  },
                ),
                const SizedBox(height: 16),
                SaveOrderPreparationTimeButton(
                  estimatedDuration: estimatedDuration,
                ),
                const SizedBox(height: 16),
                ConfirmOrderButton(
                  onConfirm: () {
                    setState(() {
                      orderStatus = "Delivered";
                    });
                  },
                ),
                const SizedBox(height: 12),
                DeleteOrderButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
