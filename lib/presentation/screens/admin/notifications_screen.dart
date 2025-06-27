import 'package:flutter/material.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/notification_form.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/notification_templete.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: Color(0xFF6F4E37),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10, left: 8, right: 8),
              padding: const EdgeInsets.only(left: 20, right: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: AdminAddNotificationTile(),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                return NotificationCard(
                  title: 'طلب جديد!',
                  body: 'وصل طلب من العميل أحمد برقم #238',
                  timestamp: DateTime.now().subtract(
                    const Duration(minutes: 4),
                  ),
                  isRead: false,
                );
              },
              itemCount: 10,
            ),
          ],
        ),
      ),
    );
  }
}
