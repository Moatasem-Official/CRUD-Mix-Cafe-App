import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mix_cafe_app/constants/app_assets.dart';
import 'package:mix_cafe_app/data/helpers/image_helper.dart';
import 'package:mix_cafe_app/data/model/user_model.dart';
import 'package:mix_cafe_app/data/services/auth/auth_service.dart';
import 'package:mix_cafe_app/data/services/cloudinary/cloudinary_services.dart';
import 'package:mix_cafe_app/data/services/firestore/firestore_services.dart';
import 'package:mix_cafe_app/presentation/widgets/customer/customer_profile_screen/custom_screen_center_section.dart';
import 'package:mix_cafe_app/presentation/widgets/customer/customer_profile_screen/custom_screen_lower_section.dart';
import 'package:mix_cafe_app/presentation/widgets/customer/customer_profile_screen/custom_screen_upper_section.dart';
import '../../widgets/customer/customer_profile_screen/custom_account_support_row_item.dart';

class CustomerProfileScreen extends StatefulWidget {
  const CustomerProfileScreen({super.key});

  @override
  State<CustomerProfileScreen> createState() => _CustomerProfileScreenState();
}

class _CustomerProfileScreenState extends State<CustomerProfileScreen> {
  final FirestoreServices _firestoreServices = FirestoreServices();
  final TextEditingController _updateAddressController =
      TextEditingController();
  String selectedLanguage = 'en';
  int index = 0;
  String name = '';
  String email = '';
  String imageUrl = '';
  String address = '';
  bool _notificationsEnabled = false;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    final userInfo = await _firestoreServices.getUserInfo(
      AuthService().currentUser!.uid,
    );
    setState(() {
      name = userInfo.name!;
      email = userInfo.email!;
      imageUrl = userInfo.imageUrl!;
      address = userInfo.address!;
      _notificationsEnabled = userInfo.isNotificationsEnabled!;
    });
  }

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
              CustomScreenUpperSection(
                onTap: () async {
                  await ImageHelper.pickFromGallery().then((value) async {
                    final cloudinaryServices = CloudinaryServices();
                    final imagePath = await cloudinaryServices
                        .uploadImageToCloudinary(File(value!.path));
                    await _firestoreServices.updateUserInfo(
                      userId: AuthService().currentUser!.uid,
                      userModel: UserModel(imageUrl: imagePath),
                    );
                    setState(() {
                      imageUrl = imagePath!;
                    });
                  });
                },
                image: imageUrl, 
                name: name,
                email: AuthService().currentUser!.email!,
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: CustomScreenCenterSection(
                  address: address == '' ? 'No address Exists' : address,
                  index: 0,
                  selectedLanguage: selectedLanguage,
                  onArabicTap: () {
                    setState(() {
                      selectedLanguage = 'ar';
                      index = 1;
                    });
                  },
                  onEnglishTap: () {
                    setState(() {
                      selectedLanguage = 'en';
                      index = 0;
                    });
                  },
                  isNotificationOn: _notificationsEnabled,
                  onNotificationTap: () async {
                    setState(() {
                      _notificationsEnabled = !_notificationsEnabled;
                    });
                    await _firestoreServices.updateUserInfo(
                      userId: AuthService().currentUser!.uid,
                      userModel: UserModel(
                        isNotificationsEnabled: _notificationsEnabled,
                      ),
                    );
                  },
                  addressController: _updateAddressController,
                  onPress: () {
                    _firestoreServices.updateUserInfo(
                      userId: AuthService().currentUser!.uid,
                      userModel: UserModel(
                        address: _updateAddressController.text,
                      ),
                    );
                    setState(() {
                      address = _updateAddressController.text;
                    });
                    Navigator.pop(context);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: CustomScreenLowerSection(),
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
                  child: InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Logout'),
                          content: const Text(
                            'Are you sure you want to logout ?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                final AuthService authService = AuthService();
                                authService.signOut();
                                Navigator.pushReplacementNamed(
                                  context,
                                  '/customerLogin',
                                );
                              },
                              child: const Text('Logout'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: CustomAccountSupportRowItem(
                        title: 'Logout',
                        backgroundColor: const Color.fromARGB(
                          255,
                          225,
                          225,
                          225,
                        ),
                        iconColor: const Color.fromARGB(255, 238, 47, 47),
                        textColor: const Color.fromARGB(255, 190, 69, 69),
                        icon: Icons.logout_rounded,
                      ),
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
