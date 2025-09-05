import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomNoProductsWidget extends StatelessWidget {
  const CustomNoProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/icons/empty-box-svgrepo-com.svg',
            height: 120,
            width: 120,
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: 300,
            child: Text(
              'Oops! Looks Like The Shelf Is Empty.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 165, 101, 56),
              ),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: 300,
            child: Text(
              'Stay Tuned! New Products Are On Their Way.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ),
        ],
      ),
    );
  }
}
