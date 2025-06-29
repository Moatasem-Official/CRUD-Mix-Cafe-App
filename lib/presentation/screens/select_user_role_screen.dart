import 'package:flutter/material.dart';
import 'package:mix_cafe_app/constants/app_images.dart';
import 'package:mix_cafe_app/presentation/widgets/User_Role_Screen_Widgets/custom_user_role_container.dart';

class SelectUserRoleScreen extends StatefulWidget {
  const SelectUserRoleScreen({super.key});

  @override
  State<SelectUserRoleScreen> createState() => _SelectUserRoleScreenState();
}

class _SelectUserRoleScreenState extends State<SelectUserRoleScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(Assets.mixCafeImageLogo, width: 300, height: 300),
              DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 24,
                  letterSpacing: 5,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF6F4E37),
                ),
                child: Text('SELECT USER ROLE'),
              ),
              const SizedBox(height: 20),
              CustomUserRoleContainer(
                buttonText: 'ADMIN',
                onTap: () => Navigator.pushNamed(context, '/adminLogin'),
                imagePath: Assets.mixCafeAdminImage,
              ),
              const SizedBox(height: 20),
              CustomUserRoleContainer(
                buttonText: 'CUSTOMER',
                onTap: () => Navigator.pushNamed(context, '/customerLogin'),
                imagePath: Assets.mixCafeCustomerImage,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
