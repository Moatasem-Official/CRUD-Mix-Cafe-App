import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../data/services/auth/auth_service.dart';
import '../../../constants/app_images.dart';
import '../../widgets/admin/custom_button.dart';
import '../../widgets/admin/custom_text_field.dart';

class CustomerLoginScreen extends StatefulWidget {
  const CustomerLoginScreen({super.key});

  @override
  State<CustomerLoginScreen> createState() => _CustomerLoginScreenState();
}

class _CustomerLoginScreenState extends State<CustomerLoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Scaffold(
          backgroundColor: const Color(0xFFFFFCF9),
          appBar: AppBar(
            backgroundColor: const Color(0xFFFFFCF9),
            elevation: 0,
            surfaceTintColor: Colors.transparent,
            automaticallyImplyLeading: true,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: size.height - kToolbarHeight,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 24),
                  Center(
                    child: Image.asset(
                      Assets.mixCafeImageLogo,
                      width: 220,
                      height: 220,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Welcome back !',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF8B4513),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          hintText: 'Email',
                          controller: _emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
                        CustomTextField(
                          hintText: 'Password',
                          controller: _passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () => Navigator.of(
                              context,
                            ).pushNamed('/forgetPassword'),
                            child: const Text(
                              'Forgot Password ?',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF8B4513),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        CustomButton(
                          buttonText: 'Login',
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              _formKey.currentState!.save();
                              try {
                                await _authService.signInWithEmailAndPassword(
                                  context,
                                  _emailController.text.trim(),
                                  _passwordController.text.trim(),
                                );

                                await FirebaseAuth.instance.currentUser!
                                    .reload();
                                User? user = FirebaseAuth.instance.currentUser;

                                if (user == null) {
                                  throw FirebaseAuthException(
                                    code: 'user-not-found',
                                  );
                                }

                                final userDoc = await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(user.uid)
                                    .get();

                                final role = userDoc.data()?['userRole'];

                                if (!userDoc.exists || role != 'customer') {
                                  await FirebaseAuth.instance.signOut();
                                  throw FirebaseAuthException(
                                    code: 'invalid-credential',
                                  );
                                }

                                if (!user.emailVerified) {
                                  await FirebaseAuth.instance.signOut();

                                  // إعادة إرسال التفعيل
                                  await user.sendEmailVerification();

                                  final snackBar = SnackBar(
                                    /// need to set following properties for best effect of awesome_snackbar_content
                                    elevation: 0,
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: Colors.transparent,
                                    content: AwesomeSnackbarContent(
                                      title: 'تحقق من البريد الإلكتروني',
                                      message:
                                          'يرجى تفعيل البريد الإلكتروني. تم إرسال رابط التفعيل مجددًا.',

                                      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                      contentType: ContentType.warning,
                                    ),
                                  );
                                  ScaffoldMessenger.of(context)
                                    ..hideCurrentSnackBar()
                                    ..showSnackBar(snackBar);

                                  setState(() {
                                    isLoading = false;
                                  });

                                  return;
                                }

                                const snackBar = SnackBar(
                                  /// need to set following properties for best effect of awesome_snackbar_content
                                  elevation: 0,
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.transparent,
                                  content: AwesomeSnackbarContent(
                                    title: 'نجاح تسجيل الدخول',
                                    message: 'تم تسجيل الدخول بنجاح كعميل',

                                    /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                    contentType: ContentType.success,
                                  ),
                                );
                                ScaffoldMessenger.of(context)
                                  ..hideCurrentSnackBar()
                                  ..showSnackBar(snackBar);
                                // ✅ تسجيل الدخول ناجح
                                Navigator.pushReplacementNamed(
                                  context,
                                  '/customerHomeScreen',
                                );
                              } on FirebaseAuthException catch (e) {
                                String message = 'فشل تسجيل الدخول';
                                if ([
                                  'user-not-found',
                                  'wrong-password',
                                  'invalid-email',
                                  'invalid-credential',
                                  'user-disabled',
                                  'too-many-requests',
                                ].contains(e.code)) {
                                  message =
                                      'البريد الإلكتروني أو كلمة المرور غير صحيحة';
                                }

                                final snackBar = SnackBar(
                                  /// need to set following properties for best effect of awesome_snackbar_content
                                  elevation: 0,
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.transparent,
                                  content: AwesomeSnackbarContent(
                                    title: 'خطأ في تسجيل الدخول',
                                    message:
                                        message, // Use the localized message here
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
                                        'حدث خطأ غير متوقع. حاول مرة أخرى لاحقًا',

                                    /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                    contentType: ContentType.failure,
                                  ),
                                );
                                ScaffoldMessenger.of(context)
                                  ..hideCurrentSnackBar()
                                  ..showSnackBar(snackBar);
                              } finally {
                                setState(() {
                                  isLoading = false;
                                });
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Don’t have an account ?',
                          style: TextStyle(color: Colors.brown, fontSize: 15),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(
                            context,
                          ).pushNamed('/customerSignUp'),
                          child: const Text(
                            'SIGN UP',
                            style: TextStyle(
                              color: Color(0xFF8B4513),
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
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
