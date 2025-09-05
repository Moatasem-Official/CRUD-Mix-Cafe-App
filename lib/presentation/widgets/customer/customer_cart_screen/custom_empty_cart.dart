import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomEmptyCart extends StatelessWidget {
  const CustomEmptyCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/animations/shopping cart.json',
            height: 200,
            width: 200,
          ),
          const SizedBox(height: 32),
          const Text(
            'Your Cart Is Empty.',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 165, 101, 56),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Fill It With Your Favorite Items!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
