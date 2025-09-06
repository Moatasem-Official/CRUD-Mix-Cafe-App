import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAdminEmptyProducts extends StatelessWidget {
  const CustomAdminEmptyProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsetsDirectional.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // أيقونة صندوق فارغ أو barcode
            SvgPicture.asset(
              'assets/icons/empty-box-svgrepo-com.svg',
              height: 150,
              width: 150,
            ),
            const SizedBox(height: 32),
            const Text(
              'No Products Found',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 165, 101, 56),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Your Product List Is Currently Empty. Add New Products To Start Selling And Managing Your Inventory.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
