import 'package:flutter/material.dart';
import 'custom_quatity_control_container.dart';

class CustomProductDetailsContainer extends StatelessWidget {
  const CustomProductDetailsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Shawarma Sandwich',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF222222),
              ),
            ),
            SizedBox(height: 12),
            Text(
              'A classic shawarma sandwich with tender, marinated meat, fresh vegetables, and creamy tahini sauce, all wrapped in a warm pita bread.',
              style: TextStyle(
                fontSize: 15,
                color: Color(0xFF666666),
                height: 1.5,
              ),
            ),
            SizedBox(height: 24),
            Text(
              'EGP 35',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF9C6B1C),
              ),
            ),
            SizedBox(height: 24),
            Text(
              'Quantity',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF222222),
              ),
            ),
            SizedBox(height: 12),
            CustomQuatityControlContainer(),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Color.fromARGB(255, 255, 217, 0),
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '4.5',
                      style: TextStyle(fontSize: 16, color: Color(0xFF666666)),
                    ),
                  ],
                ),
                const SizedBox(width: 8),
                Text(
                  '(200 reviews)',
                  style: TextStyle(fontSize: 14, color: Color(0xFF999999)),
                ),
              ],
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.attach_money_rounded,
                  color: const Color(0xFF9C6B1C),
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Payment on delivery ( Cash Only )',
                  style: TextStyle(fontSize: 16, color: Color(0xFF666666)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
