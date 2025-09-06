import 'package:flutter/material.dart';
import '../../../constants/app_assets.dart';

class AboutMixCafeScreen extends StatelessWidget {
  const AboutMixCafeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'About Mix Cafe',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(
          255,
          196,
          110,
          13,
        ), // لون كوفي أنيق
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsetsDirectional.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // الشعار أو صورة معبرة
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  Assets.mixCafeImageLogo,
                  height: 200,
                  width: 200,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // العنوان الرئيسي
            const Text(
              'Welcome to Mix Cafe',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 196, 110, 13),
              ),
            ),
            const SizedBox(height: 12),

            // الوصف الرئيسي
            const Text(
              'Mix Cafe is your ultimate destination for the perfect blend of coffee, cozy atmosphere, and a unique café experience. Since our beginning, we have been committed to serving freshly brewed coffee, delicious pastries, and handcrafted beverages in a warm and inviting space.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 20),

            // مهمتنا
            const Text(
              'Our Mission',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 196, 110, 13),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'To deliver the best quality coffee and food, and to create a community space where everyone feels welcome and relaxed.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 20),

            // رؤيتنا
            const Text(
              'Our Vision',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 196, 110, 13),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'To become a leading café brand known for innovation, flavor, and exceptional customer experience.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 20),

            // تواصل معنا
            const Text(
              'Contact Us',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 196, 110, 13),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              '📍 Location: Mansoura, Egypt\n📞 Phone: +20 101 813 4103\n✉️ Email: moatasemnagy92@gmail.com\n',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 40),

            // تذييل
            const Center(
              child: Text(
                '© 2025 Mix Cafe. All rights reserved.',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
