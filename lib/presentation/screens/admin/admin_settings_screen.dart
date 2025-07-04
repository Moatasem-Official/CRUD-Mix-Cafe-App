import 'package:flutter/material.dart';
import '../../widgets/admin/Settings_Screen_Widgets/cafe_settings_container.dart';
import '../../widgets/admin/Settings_Screen_Widgets/admin_account_container.dart';
import '../../widgets/admin/Settings_Screen_Widgets/security_settings_container.dart';

class AdminSettingsScreen extends StatefulWidget {
  const AdminSettingsScreen({super.key});

  @override
  State<AdminSettingsScreen> createState() => _AdminSettingsScreenState();
}

class _AdminSettingsScreenState extends State<AdminSettingsScreen> {
  bool isOrdersActivated = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Admin Settings',
          style: TextStyle(
            color: Color.fromARGB(255, 165, 101, 56),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AdminAccountContainer(),
              CafeSettingsContainer(
                isOrdersActivated: isOrdersActivated,
                onOrdersSwitchChanged: (value) {
                  setState(() {
                    isOrdersActivated = value;
                  });
                },
              ),
              SecuritySettingsContainer(),
              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  '© 2025 Mix Cafe. All rights reserved.',
                  style: TextStyle(color: Colors.grey, fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
