import 'package:flutter/material.dart';
import 'package:mix_cafe_app/presentation/screens/customers/customer_forget_password_screen.dart';
import 'package:mix_cafe_app/presentation/screens/customers/customer_login_screen.dart';
import 'package:mix_cafe_app/presentation/screens/customers/customer_sign_up_screen.dart';
import 'package:mix_cafe_app/presentation/screens/home_screen.dart';
import 'package:mix_cafe_app/presentation/screens/admin/admin_login_screen.dart';
import 'package:mix_cafe_app/presentation/screens/select_user_role_screen.dart';
import 'package:mix_cafe_app/presentation/screens/splash_screen.dart';

class AppRouter {
  static const String splash = '/';
  static const String selectUserRole = '/selectUserRole';
  static const String adminLogin = '/adminLogin';
  static const String customerLogin = '/customerLogin';
  static const String customerSignUp = '/customerSignUp';
  static const String forgetPassword = '/forgetPassword';
  static const String home = '/home';

  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case selectUserRole:
        return MaterialPageRoute(builder: (_) => const SelectUserRoleScreen());
      case adminLogin:
        return MaterialPageRoute(builder: (_) => const AdminLoginScreen());
      case customerLogin:
        return MaterialPageRoute(builder: (_) => const CustomerLoginScreen());
      case customerSignUp:
        return MaterialPageRoute(builder: (_) => const CustomerSignUpScreen());
      case forgetPassword:
        return MaterialPageRoute(
          builder: (_) => const CustomerForgetPasswordScreen(),
        );
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      default:
        return null;
    }
  }
}
