import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomEmptyOrders extends StatelessWidget {
  const CustomEmptyOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/icons/empty-cart-svgrepo-com.svg',
            height: 120,
            width: 120,
          ),
          const SizedBox(height: 32),
          const Text(
            'You Haven\'t Placed Any Orders Yet.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 165, 101, 56),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Start Your Shopping Journey Now!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
