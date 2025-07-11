import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SettingsServices {
  String? adminEmail;
  String? contactPhone;
  String? startWorkHours;
  String? finishWorkHours;
  bool? isOrdersActivated;

  Future<void> fetchAdminSettings() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .get();

      final adminDoc = snapshot.docs.firstWhere(
        (doc) => doc['userRole'] == 'admin',
        orElse: () => throw Exception('No admin user found'),
      );

      adminEmail = adminDoc['email'] ?? '';
      contactPhone = adminDoc['contactPhone'] ?? '';
      startWorkHours = adminDoc['starting_working_hours'] ?? '';
      finishWorkHours = adminDoc['finishing_working_hours'] ?? '';
      isOrdersActivated = adminDoc['isOrdersActivated'] as bool;
    } catch (e) {
      debugPrint('Error fetching admin data: $e');
    }
  }
}
