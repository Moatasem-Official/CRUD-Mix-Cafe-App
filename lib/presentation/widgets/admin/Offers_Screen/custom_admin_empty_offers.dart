import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAdminEmptyOffers extends StatelessWidget {
  const CustomAdminEmptyOffers({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // أيقونة شارة خصم أو "tag" فارغة
            SvgPicture.asset(
              'assets/icons/discount-svgrepo-com.svg',
              height: 150,
              width: 150,
            ),
            const SizedBox(height: 32),
            const Text(
              'No Active Offers Found',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 165, 101, 56),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Create New Offers And Promotions To Attract More Customers And Boost Sales.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
