import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAdminEmptyOrders extends StatelessWidget {
  const CustomAdminEmptyOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // أيقونة Lottie متحركة لشخص يسترخي أو مؤشرات إحصائية
            SvgPicture.asset(
              'assets/icons/shipped-svgrepo-com.svg',
              height: 200,
              width: 200,
            ),
            const SizedBox(height: 32),
            const Text(
              'No New Orders',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 165, 101, 56),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'You Currently Have No New Orders To Process. Enjoy The Quiet Moment!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
