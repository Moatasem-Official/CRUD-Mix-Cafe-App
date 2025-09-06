import 'package:flutter/material.dart';

class CustomAddOfferButton extends StatelessWidget {
  const CustomAddOfferButton({super.key, required this.onAddOffer});

  final Function() onAddOffer;

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = const Color.fromARGB(255, 165, 101, 56);
    return ElevatedButton(
      onPressed: onAddOffer,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        backgroundColor: primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 5,
      ),
      child: const Text(
        'Add Offer',
        style: TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
