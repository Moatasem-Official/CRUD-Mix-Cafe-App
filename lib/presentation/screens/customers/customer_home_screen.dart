import 'package:flutter/material.dart';
import '../../../data/services/auth/auth_service.dart';

class CustomerHomeScreen extends StatelessWidget {
  CustomerHomeScreen({super.key});

  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Customer Home',
          style: TextStyle(
            color: Color.fromARGB(255, 165, 101, 56),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        actions: [
          IconButton(
            tooltip: 'Notifications',
            style: ButtonStyle(
              overlayColor: WidgetStateProperty.all(Colors.transparent),
            ),
            onPressed: () async {
              await authService.signOut();
              Navigator.of(context).pushReplacementNamed('/customerLogin');
            },
            icon: const Icon(Icons.exit_to_app, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
