import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../data/model/user_model.dart';
import '../../../data/services/auth/auth_service.dart';
import '../../../constants/app_assets.dart';
import '../../widgets/admin/custom_button.dart';
import '../../widgets/admin/custom_rich_text.dart';
import '../../widgets/admin/custom_text_field.dart';

class CustomerSignUpScreen extends StatefulWidget {
  const CustomerSignUpScreen({super.key});

  @override
  State<CustomerSignUpScreen> createState() => _CustomerSignUpScreenState();
}

class _CustomerSignUpScreenState extends State<CustomerSignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final AuthService _authService = AuthService();
  final UserModel _userModel = UserModel();
  var agreementChecked = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    Assets.mixCafeImageLogo,
                    width: 300,
                    height: 300,
                  ),
                ),
                Text(
                  'SIGN UP',
                  style: TextStyle(
                    fontSize: 24,
                    letterSpacing: 5,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF6F4E37),
                  ),
                ),
                const SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        validator: (value) {
                          return value!.isEmpty
                              ? 'Please enter your name'
                              : null;
                        },
                        hintText: 'Name',
                        controller: _nameController,
                      ),
                      CustomTextField(
                        validator: (value) {
                          return value!.isEmpty
                              ? 'Please enter your email'
                              : null;
                        },
                        hintText: 'Email',
                        controller: _emailController,
                      ),
                      CustomTextField(
                        validator: (value) {
                          return value!.isEmpty
                              ? 'Please enter your password'
                              : null;
                        },
                        hintText: 'Password',
                        controller: _passwordController,
                      ),
                      CustomTextField(
                        validator: (value) {
                          return value!.isEmpty
                              ? 'Please enter your password'
                              : null;
                        },
                        hintText: 'Confirm Password',
                        controller: _confirmPasswordController,
                      ),
                      CustomRichText(
                        checked: agreementChecked,
                        onChanged: (value) =>
                            setState(() => agreementChecked = value!),
                      ),
                      CustomButton(
                        buttonText: 'SIGN UP',
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            _formKey.currentState!.save();

                            if (_passwordController.text ==
                                _confirmPasswordController.text) {
                              if (!agreementChecked) {
                                const snackBar = SnackBar(
                                  /// need to set following properties for best effect of awesome_snackbar_content
                                  elevation: 0,
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.transparent,
                                  content: AwesomeSnackbarContent(
                                    title: 'خطأ في التسجيل',
                                    message:
                                        'يجب عليك الموافقة على الشروط والأحكام للتسجيل',

                                    /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                    contentType: ContentType.failure,
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

                              try {
                                // إنشاء الحساب
                                await _authService
                                    .createUserWithEmailAndPassword(
                                      context,
                                      _emailController.text.trim(),
                                      _passwordController.text.trim(),
                                    );

                                final uid =
                                    FirebaseAuth.instance.currentUser!.uid;

                                // حفظ بيانات المستخدم في Firestore
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(uid)
                                    .set(
                                      UserModel(
                                        name: _nameController.text.trim(),
                                        email: _emailController.text.trim(),
                                        userRole: 'customer',
                                      ).toJson(),
                                    );

                                // إرسال رابط التحقق
                                try {
                                  await FirebaseAuth.instance.currentUser!
                                      .sendEmailVerification();

                                  const snackBar = SnackBar(
                                    /// need to set following properties for best effect of awesome_snackbar_content
                                    elevation: 0,
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: Colors.transparent,
                                    content: AwesomeSnackbarContent(
                                      title: 'رابط التحقق تم إرساله',
                                      message:
                                          'تم التسجيل بنجاح! تحقق من بريدك الإلكتروني الآن',

                                      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                      contentType: ContentType.success,
                                    ),
                                  );
                                  ScaffoldMessenger.of(context)
                                    ..hideCurrentSnackBar()
                                    ..showSnackBar(snackBar);

                                  Navigator.of(
                                    context,
                                  ).pushReplacementNamed('/customerLogin');
                                } catch (e) {
                                  const snackBar = SnackBar(
                                    /// need to set following properties for best effect of awesome_snackbar_content
                                    elevation: 0,
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: Colors.transparent,
                                    content: AwesomeSnackbarContent(
                                      title: 'خطأ في إرسال رابط التحقق',
                                      message:
                                          'حدث خطأ أثناء محاولة إرسال رابط التحقق إلى بريدك الإلكتروني. يرجى المحاولة مرة أخرى لاحقًا.',

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

                                Navigator.of(
                                  context,
                                ).pushReplacementNamed('/customerLogin');
                              } on FirebaseAuthException catch (e) {
                                String message = 'حدث خطأ أثناء التسجيل';
                                if (e.code == 'email-already-in-use') {
                                  message = 'البريد الإلكتروني مستخدم بالفعل';
                                } else if (e.code == 'invalid-email') {
                                  message = 'البريد الإلكتروني غير صالح';
                                } else if (e.code == 'weak-password') {
                                  message = 'كلمة المرور ضعيفة جداً';
                                }

                                final snackBar = SnackBar(
                                  /// need to set following properties for best effect of awesome_snackbar_content
                                  elevation: 0,
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.transparent,
                                  content: AwesomeSnackbarContent(
                                    title: 'خطأ في التسجيل',
                                    message:
                                        message, // Use the localized message here
                                    /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                    contentType: ContentType.failure,
                                  ),
                                );
                                ScaffoldMessenger.of(context)
                                  ..hideCurrentSnackBar()
                                  ..showSnackBar(snackBar);

                                // Show error message
                              } catch (e) {
                                const snackBar = SnackBar(
                                  /// need to set following properties for best effect of awesome_snackbar_content
                                  elevation: 0,
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.transparent,
                                  content: AwesomeSnackbarContent(
                                    title: 'خطأ في التسجيل',
                                    message:
                                        'حدث خطأ غير متوقع أثناء التسجيل. يرجى المحاولة مرة أخرى لاحقًا.',

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
                            } else {
                              const snackBar = SnackBar(
                                /// need to set following properties for best effect of awesome_snackbar_content
                                elevation: 0,
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                                content: AwesomeSnackbarContent(
                                  title: 'خطأ في التسجيل',
                                  message:
                                      'كلمة المرور وتأكيد كلمة المرور غير متطابقتين. يرجى التحقق من المدخلات الخاصة بك.',

                                  /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                  contentType: ContentType.failure,
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(snackBar);
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account ? ',
                      style: TextStyle(color: Colors.grey[600], fontSize: 16),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'LOGIN',
                        style: TextStyle(
                          color: Color.fromARGB(255, 165, 101, 56),
                          fontSize: 14,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
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
