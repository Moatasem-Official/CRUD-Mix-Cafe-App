import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyOffersWidget extends StatelessWidget {
  const EmptyOffersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/animations/coming soon.json'),
          const SizedBox(height: 32),
          const Text(
            'New Deals Are On Their Way!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 165, 101, 56),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Stay Tuned For Amazing Offers And Discounts.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
