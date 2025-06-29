import 'package:flutter/material.dart';

class AdminAddNotificationTile extends StatefulWidget {
  const AdminAddNotificationTile({super.key});

  @override
  State<AdminAddNotificationTile> createState() =>
      _AdminAddNotificationTileState();
}

class _AdminAddNotificationTileState extends State<AdminAddNotificationTile> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  final TextEditingController _userIdController = TextEditingController();

  String _selectedTarget = 'all'; // ممكن تغيرها لاحقًا حسب المستخدمين

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: const Text(
            'إضافة إشعار',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // عنوان الإشعار
                    TextFormField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        labelText: 'عنوان الإشعار',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) =>
                          value == null || value.isEmpty ? 'مطلوب' : null,
                    ),
                    const SizedBox(height: 16),

                    // محتوى الإشعار
                    TextFormField(
                      controller: _bodyController,
                      decoration: const InputDecoration(
                        labelText: 'محتوى الإشعار',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                      validator: (value) =>
                          value == null || value.isEmpty ? 'مطلوب' : null,
                    ),
                    const SizedBox(height: 16),

                    // Dropdown لاختيار المستلم
                    DropdownButtonFormField<String>(
                      value: _selectedTarget,
                      decoration: const InputDecoration(
                        labelText: 'إرسال إلى',
                        border: OutlineInputBorder(),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'all',
                          child: Text('كل المستخدمين'),
                        ),
                        DropdownMenuItem(
                          value: 'user_123',
                          child: Text('مستخدم معيّن'),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedTarget = value!;
                        });
                      },
                    ),
                    const SizedBox(height: 24),

                    _selectedTarget == 'user_123'
                        ? Column(
                            children: [
                              TextFormField(
                                controller: _userIdController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  labelText: 'ID المستخدم',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              const SizedBox(height: 16),
                            ],
                          )
                        : const SizedBox(),
                    // زر إرسال
                    ElevatedButton.icon(
                      icon: const Icon(Icons.send),
                      label: const Text('إرسال الإشعار'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6F4E37),
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // هنا تقدر تخزن البيانات في Firestore
                          debugPrint('✅ Title: ${_titleController.text}');
                          debugPrint('✅ Body: ${_bodyController.text}');
                          debugPrint('✅ Target: $_selectedTarget');

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('تم إرسال الإشعار (محليًا)'),
                            ),
                          );

                          // تفريغ الحقول
                          _titleController.clear();
                          _bodyController.clear();
                          setState(() => _selectedTarget = 'all');
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
