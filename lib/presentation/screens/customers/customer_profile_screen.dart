import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mix_cafe_app/bussines_logic/cubits/customer/profile_screen/cubit/profile_cubit.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:mix_cafe_app/data/helpers/custom_snack_bar.dart';
import 'package:mix_cafe_app/data/helpers/when_loading_widget.dart';
import '../../../data/helpers/image_helper.dart';
import '../../../data/model/user_model.dart';
import '../../../data/services/auth/auth_service.dart';
import '../../../data/services/cloudinary/cloudinary_services.dart';
import '../../../data/services/firestore/firestore_services.dart';
import '../../widgets/customer/customer_profile_screen/custom_screen_center_section.dart';
import '../../widgets/customer/customer_profile_screen/custom_screen_lower_section.dart';
import '../../widgets/customer/customer_profile_screen/custom_screen_upper_section.dart';
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
    final user = AuthService().currentUser;
    if (user == null) return; // المستخدم لسه مش داخل أو سجل خروج

    final userInfo = await _firestoreServices.getUserInfo(user.uid);

    if (!mounted) return;
    setState(() {
      name = userInfo.name ?? '';
      email = userInfo.email ?? '';
      imageUrl = userInfo.imageUrl ?? '';
      address = userInfo.address ?? '';
      _notificationsEnabled = userInfo.isNotificationsEnabled ?? false;
    });
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocListener<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is ProfileSignOutLoading) {
              setState(() {
                isLoading = true;
              });
            } else if (state is ProfileSignOutSuccess) {
              setState(() => isLoading = false);

              ScaffoldMessenger.of(context).showSnackBar(
                CustomSnackBar(
                  message: state.message,
                  title: 'Success',
                  contentType: ContentType.success,
                ),
              );

              Future.delayed(const Duration(seconds: 1), () {
                if (mounted) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/customerLogin',
                    (route) => false,
                  );
                }
              });
            } else if (state is ProfileSignOutError) {
              setState(() {
                isLoading = false;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                CustomSnackBar(
                  message: state.error,
                  title: 'Error',
                  contentType: ContentType.failure,
                ),
              );
            }
          },
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              title: Text(
                'Profile',
                style: TextStyle(
                  color: const Color.fromARGB(255, 165, 101, 56),
                  fontWeight: FontWeight.bold,
                ),
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
                      email: email,
                    ),
                    const SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 8),
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
                          onTap: () async {
                            final shouldProceed = await showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Logout'),
                                content: const Text(
                                  'Are you sure you want to logout ?',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, false),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, true),
                                    child: const Text('Logout'),
                                  ),
                                ],
                              ),
                            );
                            if (shouldProceed == true) {
                              context.read<ProfileCubit>().signOut();
                            }
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
          ),
        ),
        isLoading ? const WhenLoadingLogInWidget() : const SizedBox(),
      ],
    );
  }
}
