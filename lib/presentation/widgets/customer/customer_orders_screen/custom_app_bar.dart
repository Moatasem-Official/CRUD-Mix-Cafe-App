import 'package:flutter/material.dart';
import 'package:mix_cafe_app/presentation/widgets/customer/customer_orders_screen/custom_filter_tag.dart';

class CustomerOrdersAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomerOrdersAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 255, 253, 251),
      elevation: 0,
      automaticallyImplyLeading: false,
      iconTheme: const IconThemeData(color: Colors.black),
      surfaceTintColor: const Color.fromARGB(255, 255, 253, 251),
      title: const Text(
        'Your Orders',
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 12, top: 12, left: 16),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: const [
                FilterTag(label: 'All'),
                FilterTag(label: 'Pending'),
                FilterTag(label: 'Delivered'),
                FilterTag(label: 'Cancelled'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
