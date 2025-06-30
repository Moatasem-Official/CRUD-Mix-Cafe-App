import 'package:flutter/material.dart';
import '../../constants/app_images.dart';
import '../widgets/User_Role_Screen_Widgets/custom_user_role_container.dart';

class SelectUserRoleScreen extends StatefulWidget {
  const SelectUserRoleScreen({super.key});

  @override
  State<SelectUserRoleScreen> createState() => _SelectUserRoleScreenState();
}

class _SelectUserRoleScreenState extends State<SelectUserRoleScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F3), // خلفية كريمي ناعمة
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // شعار الكافيه
                Center(
                  child: Image.asset(
                    Assets.mixCafeImageLogo,
                    width: size.width * 0.6,
                  ),
                ),

                const SizedBox(height: 30),

                // عنوان الصفحة
                const Text(
                  'Welcome To Mix Cafe',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF6F4E37),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Please Choose Your Role To Continue',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),

                const SizedBox(height: 40),

                // زر الأدمن
                CustomUserRoleContainer(
                  buttonText: 'ADMIN',
                  onTap: () => Navigator.pushNamed(context, '/adminLogin'),
                  imagePath: Assets.mixCafeAdminImage,
                ),

                const SizedBox(height: 24),

                // زر العميل
                CustomUserRoleContainer(
                  buttonText: 'CUSTOMER',
                  onTap: () => Navigator.pushNamed(context, '/customerLogin'),
                  imagePath: Assets.mixCafeCustomerImage,
                ),

                const SizedBox(height: 40),

                // توقيع خفيف تحت
                const Text(
                  'Made with ☕ by Mix Cafe',
                  style: TextStyle(fontSize: 14, color: Colors.brown),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
