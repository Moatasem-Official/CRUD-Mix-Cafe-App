import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mix_cafe_app/data/services/auth/auth_service.dart';
import '../../widgets/admin/Settings_Screen_Widgets/cafe_settings_container.dart';
import '../../widgets/admin/Settings_Screen_Widgets/admin_account_container.dart';
import '../../widgets/admin/Settings_Screen_Widgets/security_settings_container.dart';

class AdminSettingsScreen extends StatefulWidget {
  const AdminSettingsScreen({super.key});

  @override
  State<AdminSettingsScreen> createState() => _AdminSettingsScreenState();
}

class _AdminSettingsScreenState extends State<AdminSettingsScreen> {
  bool isOrdersActivated = false;
  final AuthService _authService = AuthService();
  String adminEmail = '';
  String contactPhone = '';
  String startWorkHours = '';
  String finishWorkHours = '';

  @override
  void initState() {
    super.initState();
    fetchAdminSettings();
  }

  Future<void> fetchAdminSettings() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .get();

      final adminDoc = snapshot.docs.firstWhere(
        (doc) => doc['userRole'] == 'admin',
        orElse: () => throw Exception('No admin user found'),
      );

      setState(() {
        adminEmail = adminDoc['email'] ?? '';
        contactPhone = adminDoc['contactPhone'] ?? '';
        startWorkHours = adminDoc['starting_working_hours'] ?? '';
        finishWorkHours = adminDoc['finishing_working_hours'] ?? '';
        isOrdersActivated = adminDoc['isOrdersActivated'] as bool;
      });
    } catch (e) {
      debugPrint('Error fetching admin data: $e');
    }
  }

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
            color: Color.fromARGB(255, 165, 101, 56),
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
              AdminAccountContainer(adminEmail: adminEmail),
              CafeSettingsContainer(
                isOrdersActivated: isOrdersActivated,
                onOrdersSwitchChanged: (value) {
                  setState(() {
                    isOrdersActivated = value;
                    _authService.updateField(
                      'isOrdersActivated',
                      isOrdersActivated,
                    );
                  });
                },
                publicContactNumber: contactPhone,
                onPublicNumberTap: () {
                  final TextEditingController phoneController =
                      TextEditingController(text: contactPhone);

                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      title: const Text(
                        'تعديل رقم تواصل المطعم العام',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 165, 101, 56),
                        ),
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'رقم التواصل',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.brown,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              hintText: 'أدخل رقم التواصل',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0xFFA0522D),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            'إلغاء',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFA0522D),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                          ),
                          onPressed: () async {
                            final newPhone = phoneController.text.trim();

                            if (newPhone.isEmpty) return;

                            try {
                              await _authService.updateField(
                                'contactPhone',
                                newPhone,
                              );

                              Navigator.pop(context);

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('تم تحديث رقم التواصل بنجاح'),
                                ),
                              );
                            } on FirebaseAuthException catch (e) {
                              Navigator.pop(context);

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.message!)),
                              );
                            } catch (e) {
                              Navigator.pop(context);

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('فشل التحديث، حاول لاحقًا'),
                                ),
                              );
                            }
                          },
                          child: const Text(
                            'تحديث',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                startWorkingHours: startWorkHours,
                endWorkingHours: finishWorkHours,
                onWorkingHoursTap: () {
                  final startTimeController = TextEditingController(
                    text: startWorkHours,
                  );
                  final endTimeController = TextEditingController(
                    text: finishWorkHours,
                  );

                  TimeOfDay? selectedStartTime;
                  TimeOfDay? selectedEndTime;

                  showDialog(
                    context: context,
                    builder: (ctx) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        title: const Text(
                          'مواعيد العمل',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF8B4513),
                          ),
                        ),
                        content: StatefulBuilder(
                          builder: (context, setState) {
                            Future<void> pickTime({
                              required bool isStart,
                            }) async {
                              final pickedTime = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );

                              if (pickedTime != null) {
                                setState(() {
                                  if (isStart) {
                                    selectedStartTime = pickedTime;
                                    startTimeController.text = pickedTime
                                        .format(context);
                                  } else {
                                    selectedEndTime = pickedTime;
                                    endTimeController.text = pickedTime.format(
                                      context,
                                    );
                                  }
                                });
                              }
                            }

                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextField(
                                  controller: startTimeController,
                                  readOnly: true,
                                  onTap: () => pickTime(isStart: true),
                                  decoration: const InputDecoration(
                                    labelText: 'وقت البداية',
                                    prefixIcon: Icon(Icons.access_time),
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                TextField(
                                  controller: endTimeController,
                                  readOnly: true,
                                  onTap: () => pickTime(isStart: false),
                                  decoration: const InputDecoration(
                                    labelText: 'وقت النهاية',
                                    prefixIcon: Icon(Icons.access_time_filled),
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(ctx),
                            child: const Text('إلغاء'),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF8B4513),
                            ),
                            onPressed: () {
                              if (selectedStartTime == null ||
                                  selectedEndTime == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'يجب تحديد وقت البداية والنهاية',
                                    ),
                                  ),
                                );
                                return;
                              }

                              // 🟤 نفذ التحديث هنا
                              final start = selectedStartTime!.format(context);
                              final end = selectedEndTime!.format(context);

                              _authService.updateField(
                                'starting_working_hours',
                                start.toString(),
                              );
                              _authService.updateField(
                                'finishing_working_hours',
                                end.toString(),
                              );

                              Navigator.pop(ctx);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'تم التحديث من $start إلى $end',
                                  ),
                                ),
                              );
                            },
                            child: const Text('تحديث'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              SecuritySettingsContainer(
                onLogoutPressed: () async {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      title: const Text(
                        'تسجيل الخروج',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF8B4513),
                        ),
                      ),
                      content: const Text('هل تريد تسجيل الخروج ؟'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(ctx),
                          child: const Text('لا'),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF8B4513),
                          ),
                          onPressed: () async {
                            await _authService.signOut();
                            Navigator.of(
                              context,
                            ).pushReplacementNamed('/adminLogin');
                          },
                          child: const Text('نعم'),
                        ),
                      ],
                    ),
                  );
                },
                onResetPasswordPressed: () async {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      title: const Text(
                        'تغيير كلمة المرور',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF8B4513),
                        ),
                      ),
                      content: const Text('هل تريد تغيير كلمة المرور ؟'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(ctx),
                          child: const Text('لا'),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF8B4513),
                          ),
                          onPressed: () async {
                            try {
                              await _authService.sendPasswordResetEmail(
                                context,
                                adminEmail,
                              );
                              Navigator.pop(ctx);
                              Navigator.of(
                                context,
                              ).pushReplacementNamed('/adminLogin');
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'تم إرسال رابط إعادة تعيين كلمة المرور',
                                  ),
                                ),
                              );
                            } catch (e) {
                              Navigator.pop(ctx);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.toString())),
                              );
                            }
                          },
                          child: const Text('نعم'),
                        ),
                      ],
                    ),
                  );
                },
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
