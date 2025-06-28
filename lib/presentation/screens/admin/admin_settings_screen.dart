import 'package:flutter/material.dart';

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
            color: Color(0xFF6F4E37),
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
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFF2B1C13), // خلفية بنية داكنة
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Admin Account',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // الاسم
                    _infoRow(Icons.person, 'Mohammed Ali', onTap: () {}),
                    const SizedBox(height: 12),

                    // الإيميل
                    _infoRow(Icons.email, 'm.all@example.com', onTap: () {}),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFF2B1C13),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Cafe Settings',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Activate orders with switch
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF3B2A1F),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.settings, color: Colors.white70),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Text(
                              'Activate orders',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Switch(
                            activeTrackColor: const Color.fromARGB(
                              255,
                              158,
                              90,
                              66,
                            ),
                            inactiveTrackColor: Colors.grey[300],
                            value: isOrdersActivated,
                            activeColor: Colors.brown[300],
                            inactiveThumbColor: Colors.grey,
                            onChanged: (value) {
                              setState(() {
                                isOrdersActivated = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Public Contact Number
                    _settingsItem(Icons.sim_card, 'Public Contact Number'),

                    const SizedBox(height: 12),

                    // Working Hours Display
                    _settingsItem(Icons.menu, 'Working Hours Display'),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF2B1C13),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Security',
                      style: TextStyle(
                        color: Color(0xFFF5E4C3), // لون كريمي فاتح زي الصورة
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    _securityItem(Icons.download_rounded, 'Reset Password'),
                    const SizedBox(height: 12),
                    _securityItem(Icons.logout, 'Log Out'),
                  ],
                ),
              ),
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

Widget _infoRow(IconData icon, String text, {Function()? onTap}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(
      color: const Color(0xFF3B2A1F),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        Icon(icon, color: Colors.white70),
        const SizedBox(width: 12),
        Expanded(
          child: Text(text, style: const TextStyle(color: Colors.white)),
        ),
        IconButton(
          icon: const Icon(Icons.edit, color: Colors.white),
          onPressed: onTap,
        ),
      ],
    ),
  );
}

Widget _settingsItem(IconData icon, String text) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(
      color: const Color(0xFF3B2A1F),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        Icon(icon, color: Colors.white70),
        const SizedBox(width: 12),
        Expanded(
          child: Text(text, style: const TextStyle(color: Colors.white)),
        ),
      ],
    ),
  );
}

Widget _securityItem(IconData icon, String label) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(
      color: const Color(0xFF3B2A1F),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        Icon(icon, color: Colors.white70),
        const SizedBox(width: 12),
        Expanded(
          child: Text(label, style: const TextStyle(color: Colors.white)),
        ),
      ],
    ),
  );
}
