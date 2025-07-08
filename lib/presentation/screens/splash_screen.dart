import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../constants/app_assets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadUserRoleAndNavigate();
    });
  }

  Future<void> _loadUserRoleAndNavigate() async {
    final currentUser = FirebaseAuth.instance.currentUser;

    // إذا لم يوجد مستخدم، انتقل مباشرة لاختيار الدور
    if (currentUser == null) {
      await Future.delayed(const Duration(seconds: 2));
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/selectUserRole');
      return;
    }

    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .get();

    final role = userDoc.data()?['userRole'];

    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;
    Navigator.pushReplacementNamed(
      context,
      role == 'admin'
          ? '/adminHomeScreen'
          : role == 'admin' && !currentUser.emailVerified
          ? '/adminLogin'
          : role == 'customer' && currentUser.emailVerified
          ? '/customerHomeScreen'
          : role == 'customer' && !currentUser.emailVerified
          ? '/customerLogin'
          : '/selectUserRole',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Image.asset(Assets.mixCafeImageLogo, width: 300, height: 300),
      ),
    );
  }
}
