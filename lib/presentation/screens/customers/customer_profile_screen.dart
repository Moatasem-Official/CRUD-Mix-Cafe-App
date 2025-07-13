import 'package:flutter/material.dart';
import 'package:mix_cafe_app/constants/app_assets.dart';
import 'package:mix_cafe_app/presentation/widgets/customer/custom_profile_screen/custom_account_addresses_row_item.dart';
import 'package:mix_cafe_app/presentation/widgets/customer/custom_profile_screen/custom_account_language_row_item.dart';
import 'package:mix_cafe_app/presentation/widgets/customer/custom_profile_screen/custom_account_notifications_row_item.dart';
import 'package:mix_cafe_app/presentation/widgets/customer/custom_profile_screen/custom_account_support_row_item.dart';

class CustomerProfileScreen extends StatefulWidget {
  const CustomerProfileScreen({super.key});

  @override
  State<CustomerProfileScreen> createState() => _CustomerProfileScreenState();
}

class _CustomerProfileScreenState extends State<CustomerProfileScreen> {
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          'Profile',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        surfaceTintColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              SizedBox(
                height: 250,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child: CircleAvatar(
                            radius: 80,
                            backgroundImage: AssetImage(
                              Assets.mixCafeAdminImage,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 5,
                          right: 5,
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 196, 110, 13),
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Moatasem Nagy',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'moatasemnagy3@gmail.com',
                      style: TextStyle(
                        fontSize: 16,
                        color: const Color.fromARGB(255, 216, 165, 52),
                      ),
                    ),
                    Text(
                      'Customer',
                      style: TextStyle(
                        fontSize: 16,
                        color: const Color.fromARGB(255, 240, 204, 126),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: SizedBox(
                  height: 320,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Account',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 16,
                                top: 16,
                                right: 8,
                              ),
                              child: CustomAccountAddressesRowItem(
                                title: 'Saved Addresses',
                                subtitle: 'Cairo, Egypt',
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Divider(
                              color: Color.fromARGB(255, 227, 227, 227),
                              height: .5,
                            ),
                            const SizedBox(height: 16),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 16,
                                right: 16,
                              ),
                              child: CustomAccountLanguageRowItem(
                                title: 'Language',
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Divider(
                              color: Color.fromARGB(255, 227, 227, 227),
                              height: .5,
                            ),
                            const SizedBox(height: 16),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 16,
                                right: 16,
                                bottom: 16,
                              ),
                              child: CustomAccountNotificationsRowItem(
                                title: 'Notifications',
                                notificationsEnabled: _notificationsEnabled,
                                onChanged: (value) {
                                  setState(() {
                                    _notificationsEnabled = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: SizedBox(
                  height: 200,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Support',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 16,
                                top: 16,
                                right: 8,
                              ),
                              child: CustomAccountSupportRowItem(
                                title: 'About Mix Cafe',
                                backgroundColor: const Color.fromARGB(
                                  255,
                                  225,
                                  225,
                                  225,
                                ),
                                iconColor: const Color.fromARGB(
                                  255,
                                  216,
                                  165,
                                  52,
                                ),
                                textColor: Colors.black,
                                icon: Icons.info_outline_rounded,
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Divider(
                              color: Color.fromARGB(255, 227, 227, 227),
                              height: .5,
                            ),
                            const SizedBox(height: 16),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 16,
                                right: 16,
                              ),
                              child: CustomAccountSupportRowItem(
                                title: 'Contact Support',
                                backgroundColor: const Color.fromARGB(
                                  255,
                                  225,
                                  225,
                                  225,
                                ),
                                iconColor: const Color.fromARGB(
                                  255,
                                  216,
                                  165,
                                  52,
                                ),
                                textColor: Colors.black,
                                icon: Icons.support_agent_rounded,
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Container(
                  width: double.infinity,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: CustomAccountSupportRowItem(
                      title: 'Logout',
                      backgroundColor: const Color.fromARGB(255, 225, 225, 225),
                      iconColor: const Color.fromARGB(255, 238, 47, 47),
                      textColor: const Color.fromARGB(255, 190, 69, 69),
                      icon: Icons.logout_rounded,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'Version 1.0.0',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
