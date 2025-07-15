import 'package:flutter/material.dart';
import '../../widgets/customer/customer_cart_screen/custom_cart_item_container.dart';
import '../../widgets/customer/customer_cart_screen/custom_checkout_container.dart';

class CustomerCartScreen extends StatefulWidget {
  const CustomerCartScreen({super.key});

  @override
  State<CustomerCartScreen> createState() => _CustomerCartScreenState();
}

class _CustomerCartScreenState extends State<CustomerCartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(
          255,
          255,
          253,
          251,
        ), // لون بيج فاتح
        elevation: 0,
        title: const Text(
          'Your Cart',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        surfaceTintColor: const Color.fromARGB(255, 255, 253, 251),
      ),
      backgroundColor: const Color.fromARGB(255, 255, 253, 251), // لون بيج فاتح
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return CustomCartItemContainer();
                },
              ),
            ),
          ),
          Expanded(flex: 1, child: CustomCheckoutContainer()),
        ],
      ),
    );
  }
}
