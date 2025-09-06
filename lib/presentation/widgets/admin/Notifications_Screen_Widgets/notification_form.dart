import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:mix_cafe_app/data/helpers/custom_snack_bar.dart';

class AdminAddNotificationTile extends StatefulWidget {
  const AdminAddNotificationTile({super.key});

  @override
  State<AdminAddNotificationTile> createState() =>
      _AdminAddNotificationTileState();
}

class _AdminAddNotificationTileState extends State<AdminAddNotificationTile> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  final _userIdController = TextEditingController();

  String _selectedTarget = 'all';

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          leading: const Icon(
            Icons.notifications_active_outlined,
            color: Color(0xFF6F4E37),
          ),
          title: const Text(
            'Send Notification',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Color(0xFF4E342E),
            ),
          ),
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 18.0,
                vertical: 12,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Notification Title
                    TextFormField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        labelText: 'Notification Title',
                        prefixIcon: const Icon(Icons.title),
                        filled: true,
                        fillColor: Colors.brown.withOpacity(0.05),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: (value) => value == null || value.isEmpty
                          ? 'This field is required'
                          : null,
                    ),
                    const SizedBox(height: 14),

                    // Notification Body
                    TextFormField(
                      controller: _bodyController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        labelText: 'Message Body',
                        prefixIcon: const Icon(Icons.message_outlined),
                        filled: true,
                        fillColor: Colors.brown.withOpacity(0.05),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: (value) => value == null || value.isEmpty
                          ? 'This field is required'
                          : null,
                    ),
                    const SizedBox(height: 14),

                    // Target Selector
                    DropdownButtonFormField<String>(
                      value: _selectedTarget,
                      decoration: InputDecoration(
                        labelText: 'Send To',
                        prefixIcon: const Icon(Icons.people_outline),
                        filled: true,
                        fillColor: Colors.brown.withOpacity(0.05),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'all',
                          child: Text('All Users'),
                        ),
                        DropdownMenuItem(
                          value: 'user_123',
                          child: Text('Specific User'),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedTarget = value!;
                        });
                      },
                    ),
                    const SizedBox(height: 14),

                    // User ID Field (conditional)
                    if (_selectedTarget == 'user_123')
                      Column(
                        children: [
                          TextFormField(
                            controller: _userIdController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'User ID',
                              prefixIcon: const Icon(Icons.numbers),
                              filled: true,
                              fillColor: Colors.brown.withOpacity(0.05),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            validator: (value) {
                              if (_selectedTarget == 'user_123' &&
                                  (value == null || value.isEmpty)) {
                                return 'User ID is required';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 14),
                        ],
                      ),

                    // Submit Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.send),
                        label: const Text('Send Notification'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6F4E37),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsetsDirectional.symmetric(
                            vertical: 14,
                          ),
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            debugPrint('📢 Title: ${_titleController.text}');
                            debugPrint('📢 Body: ${_bodyController.text}');
                            debugPrint('👤 Target: $_selectedTarget');
                            if (_selectedTarget == 'user_123') {
                              debugPrint(
                                '🔍 User ID: ${_userIdController.text}',
                              );
                            }

                            ScaffoldMessenger.of(context).showSnackBar(
                              CustomSnackBar(
                                message: 'Notification Sent Successfully',
                                title: 'Success',
                                contentType: ContentType.success,
                              ),
                            );

                            // Reset form
                            _titleController.clear();
                            _bodyController.clear();
                            _userIdController.clear();
                            setState(() => _selectedTarget = 'all');
                          }
                        },
                      ),
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
