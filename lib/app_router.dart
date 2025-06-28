import 'package:flutter/material.dart';
import 'package:mix_cafe_app/presentation/screens/admin/admin_settings_screen.dart';
import 'package:mix_cafe_app/presentation/screens/admin/analytics_home_screen.dart';
import 'package:mix_cafe_app/presentation/screens/admin/categories_managment_screen.dart';
import 'package:mix_cafe_app/presentation/screens/admin/category_products_screen.dart';
import 'package:mix_cafe_app/presentation/screens/admin/notifications_screen.dart';
import 'package:mix_cafe_app/presentation/screens/admin/orders_managment_screen.dart';
import 'package:mix_cafe_app/presentation/screens/admin/product_information_form.dart';
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
  static const String categoriesManagment = '/categories_managment';
  static const String categoryProducts = '/categoryProducts';
  static const String productInformationForm = '/productInformationForm';
  static const String ordersManagment = '/ordersManagment';
  static const String notifications = '/notifications';
  static const String analyticsHome = '/analyticsHome';
  static const String adminSettingsScreen = '/adminSettingsScreen';
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
      case categoriesManagment:
        return MaterialPageRoute(
          builder: (_) => const CategoriesManagmentScreen(),
        );
      case categoryProducts:
        final categoryName = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => CategoryProductsScreen(categoryName: categoryName),
        );
      case productInformationForm:
        return MaterialPageRoute(
          builder: (_) => const ProductInformationForm(),
        );
      case ordersManagment:
        return MaterialPageRoute(builder: (_) => const OrdersManagmentScreen());
      case notifications:
        return MaterialPageRoute(builder: (_) => const NotificationsScreen());
      case analyticsHome:
        return MaterialPageRoute(builder: (_) => const AnalyticsHomeScreen());
      case adminSettingsScreen:
        return MaterialPageRoute(builder: (_) => const AdminSettingsScreen());
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
