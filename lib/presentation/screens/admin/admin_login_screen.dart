import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../data/services/auth/auth_service.dart';
import '../../../constants/app_assets.dart';
import '../../widgets/admin/custom_button.dart';
import '../../widgets/admin/custom_text_field.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            surfaceTintColor: Colors.white,
            automaticallyImplyLeading: true,
            backgroundColor: Colors.white,
          ),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      Assets.mixCafeImageLogo,
                      width: 300,
                      height: 300,
                    ),
                  ),
                  Text(
                    'ADMIN',
                    style: TextStyle(
                      fontSize: 24,
                      letterSpacing: 5,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF6F4E37),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          validator: (value) =>
                              value!.isEmpty ? 'Enter email' : null,
                          hintText: 'Email',
                          controller: emailController,
                        ),
                        CustomTextField(
                          validator: (value) =>
                              value!.isEmpty ? 'Enter password' : null,
                          hintText: 'Password',
                          controller: passwordController,
                        ),
                        CustomButton(
                          buttonText: 'LOGIN',
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              setState(() => isLoading = true);
                              formKey.currentState!.save();
                              try {
                                final authService = AuthService();

                                await authService.signInWithEmailAndPassword(
                                  context,
                                  emailController.text.trim(),
                                  passwordController.text.trim(),
                                );

                                final user = authService.currentUser;

                                if (user == null) {
                                  throw FirebaseAuthException(
                                    code: 'user-not-found',
                                  );
                                }

                                final doc = await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(user.uid)
                                    .get();

                                final role = doc.data()?['userRole'];

                                if (!doc.exists || role != 'admin') {
                                  await authService.signOut();
                                  throw FirebaseAuthException(
                                    code: 'invalid-credential',
                                  );
                                }

                                const snackBar = SnackBar(
                                  /// need to set following properties for best effect of awesome_snackbar_content
                                  elevation: 0,
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.transparent,
                                  content: AwesomeSnackbarContent(
                                    title: 'نجاح تسجيل الدخول',
                                    message: 'تم تسجيل الدخول بنجاح كمسؤول',

                                    /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                    contentType: ContentType.success,
                                  ),
                                );
                                ScaffoldMessenger.of(context)
                                  ..hideCurrentSnackBar()
                                  ..showSnackBar(snackBar);
                                // نجاح الدخول
                                Navigator.pushReplacementNamed(
                                  context,
                                  '/adminHomeScreen',
                                );
                              } on FirebaseAuthException catch (_) {
                                const snackBar = SnackBar(
                                  /// need to set following properties for best effect of awesome_snackbar_content
                                  elevation: 0,
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.transparent,
                                  content: AwesomeSnackbarContent(
                                    title: 'خطأ في تسجيل الدخول',
                                    message:
                                        'البريد الإلكتروني أو كلمة المرور غير صحيحة',

                                    /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                    contentType: ContentType.failure,
                                  ),
                                );
                                ScaffoldMessenger.of(context)
                                  ..hideCurrentSnackBar()
                                  ..showSnackBar(snackBar);
                              } catch (_) {
                                const snackBar = SnackBar(
                                  /// need to set following properties for best effect of awesome_snackbar_content
                                  elevation: 0,
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.transparent,
                                  content: AwesomeSnackbarContent(
                                    title: 'خطأ في تسجيل الدخول',
                                    message:
                                        'حدث خطأ غير متوقع. يرجى المحاولة مرة أخرى لاحقًا',

                                    /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                    contentType: ContentType.failure,
                                  ),
                                );
                                ScaffoldMessenger.of(context)
                                  ..hideCurrentSnackBar()
                                  ..showSnackBar(snackBar);
                              } finally {
                                setState(() => isLoading = false);
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'I am not admin ?',
                        style: TextStyle(fontSize: 12, color: Colors.blueGrey),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: const Color.fromARGB(
                            255,
                            232,
                            206,
                            187,
                          ),
                          textStyle: const TextStyle(fontSize: 16),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/customerLogin');
                        },
                        child: const Text(
                          'Login as Customer',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF6F4E37),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        if (isLoading)
          Container(
            color: Colors.black.withOpacity(0.5), // ظل شفاف
            child: Center(
              child: Image.asset(
                'assets/animations/Animation - 1751644034977.gif',
                width: 250, // الحجم الذي تريده
                height: 250,
                fit: BoxFit.contain,
              ),
            ),
          ),
      ],
    );
  }
}
