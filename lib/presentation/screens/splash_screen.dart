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
    // Warten Sie 2 Sekunden, damit der Splash-Screen sichtbar ist (gute UX)
    await Future.delayed(const Duration(seconds: 2));

    // Prüfen Sie nach der Verzögerung, ob das Widget noch im Widget-Baum ist
    if (!mounted) return;

    final currentUser = FirebaseAuth.instance.currentUser;

    // Fall 1: Kein Benutzer ist angemeldet
    if (currentUser == null) {
      Navigator.pushReplacementNamed(context, '/selectUserRole');
      return;
    }

    // Fall 2: Ein Benutzer ist angemeldet, holen Sie seine Rolle
    try {
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .get();

      // Erneut prüfen, ob das Widget nach dem Firestore-Aufruf noch vorhanden ist
      if (!mounted) return;

      // Sicherstellen, dass das Benutzerdokument existiert
      if (userDoc.exists && userDoc.data() != null) {
        final role = userDoc.data()!['userRole'];

        if (role == 'admin') {
          // Korrekte Navigation für Admins
          if (currentUser.emailVerified) {
            Navigator.pushReplacementNamed(context, '/adminHomeScreen');
          } else {
            // Dieser Fall war vorher unerreichbar
            Navigator.pushReplacementNamed(context, '/adminLogin');
          }
        } else if (role == 'customer') {
          // Korrekte Navigation für Kunden
          if (currentUser.emailVerified) {
            Navigator.pushReplacementNamed(context, '/customerOrdersScreen');
          } else {
            Navigator.pushReplacementNamed(context, '/customerLogin');
          }
        } else {
          // Die Rolle ist ungültig oder null
          Navigator.pushReplacementNamed(context, '/selectUserRole');
        }
      } else {
        // Das Benutzerdokument existiert nicht in Firestore
        // Dies verhindert einen Absturz, wenn 'userRole' nicht gefunden wird
        Navigator.pushReplacementNamed(context, '/selectUserRole');
      }
    } catch (e) {
      // Fehler bei Firestore-Aufrufen (z.B. Netzwerkprobleme) abfangen
      if (!mounted) return;
      debugPrint("Fehler beim Laden der Benutzerdaten: $e");
      // Leiten Sie den Benutzer zu einer sicheren Fallback-Seite
      Navigator.pushReplacementNamed(context, '/selectUserRole');
    }
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
