import 'package:flutter/material.dart';
import '../../../data/services/auth/auth_service.dart';
import '../../../data/services/firestore/settings_services.dart';
import '../../widgets/admin/Settings_Screen_Widgets/admin_log_out.dart';
import '../../widgets/admin/Settings_Screen_Widgets/edit_contact_phone_num.dart';
import '../../widgets/admin/Settings_Screen_Widgets/edit_working_hours.dart';
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
  final SettingsServices _settingsService = SettingsServices();

  String adminEmail = '';
  String contactPhone = '';
  String startWorkHours = '';
  String finishWorkHours = '';

  @override
  void initState() {
    super.initState();
    _loadAdminSettings();
  }

  Future<void> _loadAdminSettings() async {
    await _settingsService.fetchAdminSettings();
    setState(() {
      isOrdersActivated = _settingsService.isOrdersActivated ?? true;
      adminEmail = _settingsService.adminEmail ?? '';
      contactPhone = _settingsService.contactPhone ?? '';
      startWorkHours = _settingsService.startWorkHours ?? '';
      finishWorkHours = _settingsService.finishWorkHours ?? '';
    });
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
                    builder: (context) => EditAdminContactPhoneNumber(
                      phoneController: phoneController,
                      authService: _authService,
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
                      return EditWorkingHours(
                        startTimeController: startTimeController,
                        endTimeController: endTimeController,
                        selectedStartTime: selectedStartTime,
                        selectedEndTime: selectedEndTime,
                        authService: _authService,
                      );
                    },
                  );
                },
              ),
              SecuritySettingsContainer(
                onLogoutPressed: () async {
                  showDialog(
                    context: context,
                    builder: (ctx) => AdminLogOut(authService: _authService),
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
