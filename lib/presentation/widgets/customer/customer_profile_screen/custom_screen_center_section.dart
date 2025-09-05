import 'package:flutter/material.dart';
import 'package:mix_cafe_app/presentation/widgets/customer/customer_profile_screen/custom_account_theme_app_row_item.dart';
import 'custom_account_addresses_row_item.dart';
import 'custom_account_language_row_item.dart';
import 'custom_account_notifications_row_item.dart';

class CustomScreenCenterSection extends StatefulWidget {
  const CustomScreenCenterSection({
    super.key,
    required this.address,
    required this.selectedLanguage,
    required this.index,
    required this.onArabicTap,
    required this.onEnglishTap,
    required this.onNotificationTap,
    required this.isNotificationOn,
    required this.onPress,
    required this.addressController,
  });

  final String address;
  final String selectedLanguage;
  final bool isNotificationOn;
  final int index;
  final TextEditingController addressController;
  final VoidCallback onArabicTap;
  final VoidCallback onEnglishTap;
  final VoidCallback onNotificationTap;
  final Function() onPress;

  @override
  State<CustomScreenCenterSection> createState() =>
      _CustomScreenCenterSectionState();
}

class _CustomScreenCenterSectionState extends State<CustomScreenCenterSection> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                GestureDetector(
                  onTap: () {
                    widget.addressController.text = widget.address;
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text(
                          'Saved Addresses',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        content: SizedBox(
                          width: double.maxFinite,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                controller: widget.addressController,
                                decoration: InputDecoration(
                                  hintText: 'Enter address',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: widget.onPress,
                                  child: const Text('Save'),
                                ),
                              ),
                            ],
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, top: 16, right: 8),
                    child: CustomAccountAddressesRowItem(
                      title: 'Saved Addresses',
                      subtitle: widget.address,
                    ),
                  ),
                ),

                const SizedBox(height: 16),
                const Divider(
                  color: Color.fromARGB(255, 227, 227, 227),
                  height: .5,
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: CustomAccountLanguageRowItem(
                    title: 'Language',
                    selectedLanguage: widget.selectedLanguage,
                    index: widget.index,
                    onArabicTap: widget.onArabicTap,
                    onEnglishTap: widget.onEnglishTap,
                  ),
                ),
                const SizedBox(height: 16),
                const Divider(
                  color: Color.fromARGB(255, 227, 227, 227),
                  height: .5,
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      isDismissible: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      context: context,
                      builder: (context) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              title: Row(
                                children: [
                                  const Icon(
                                    Icons.light_mode,
                                    color: Color.fromARGB(255, 216, 165, 52),
                                  ),
                                  const SizedBox(width: 16),
                                  const Text(
                                    'Light',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                              onTap: () {
                                Navigator.pop(context, 0);
                                setState(() {
                                  currentIndex = 0;
                                });
                              },
                            ),
                            ListTile(
                              title: Row(
                                children: [
                                  const Icon(
                                    Icons.dark_mode,
                                    color: Color.fromARGB(255, 216, 165, 52),
                                  ),
                                  const SizedBox(width: 16),
                                  const Text(
                                    'Dark',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                              onTap: () {
                                Navigator.pop(context, 1);
                                setState(() {
                                  currentIndex = 1;
                                });
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: CustomAccountThemeAppRowItem(
                      title: 'Theme',
                      index: currentIndex,
                    ),
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
                    notificationsEnabled: widget.isNotificationOn,
                    onChanged: (value) {
                      widget.onNotificationTap();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
