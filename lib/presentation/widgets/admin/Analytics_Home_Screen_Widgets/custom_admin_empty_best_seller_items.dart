import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAdminEmptyBestSellerItems extends StatelessWidget {
  const CustomAdminEmptyBestSellerItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsetsDirectional.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // أيقونة صندوق فارغ، تعطي إحساسًا بالبيانات المفقودة
            SvgPicture.asset(
              'assets/icons/data-null-svgrepo-com.svg',
              height: 150,
              width: 150,
            ),
            const SizedBox(height: 32),
            const Text(
              'No Best-Selling Products Found',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 165, 101, 56),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'This List Will Populate With Your Top-Selling Products As Sales Data Comes In. Ensure Your Products Are Well-Stocked And Promoted To See Them Here.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
