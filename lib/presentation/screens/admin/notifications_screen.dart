import 'package:flutter/material.dart';
import '../../widgets/admin/Notifications_Screen_Widgets/notification_form.dart';
import '../../widgets/admin/Notifications_Screen_Widgets/notification_templete.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color(0xFF6F4E37),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
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
              decoration: BoxDecoration(
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
                  title: 'New Order !',
                  body: 'You Have A new Order From Customer ${index + 1}',
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
