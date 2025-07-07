import 'package:flutter/material.dart';
import 'presentation/screens/admin/order_details_screen.dart';
import 'presentation/screens/customers/customer_home_screen.dart';
import 'presentation/screens/admin/admin_home_screen.dart';
import 'presentation/screens/admin/admin_settings_screen.dart';
import 'presentation/screens/admin/analytics_home_screen.dart';
import 'presentation/screens/admin/categories_managment_screen.dart';
import 'presentation/screens/admin/category_products_screen.dart';
import 'presentation/screens/admin/notifications_screen.dart';
import 'presentation/screens/admin/orders_managment_screen.dart';
import 'presentation/screens/admin/add_product_information_form.dart';
import 'presentation/screens/customers/customer_forget_password_screen.dart';
import 'presentation/screens/customers/customer_login_screen.dart';
import 'presentation/screens/customers/customer_sign_up_screen.dart';
import 'presentation/screens/admin/admin_login_screen.dart';
import 'presentation/screens/select_user_role_screen.dart';
import 'presentation/screens/splash_screen.dart';

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
  static const String adminHomeScreen = '/adminHomeScreen';
  static const String adminSettingsScreen = '/adminSettingsScreen';
  static const String adminOrderDetailsScreen = '/adminOrderDetailsScreen';
  static const String customerLogin = '/customerLogin';
  static const String customerSignUp = '/customerSignUp';
  static const String forgetPassword = '/forgetPassword';
  static const String customerHomeScreen = '/customerHomeScreen';

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
        return MaterialPageRoute(
          builder: (_) => CategoryProductsScreen(
            categoryId: settings.arguments as int, // Pass the category ID
          ),
        );
      case productInformationForm:
        return MaterialPageRoute(
          builder: (_) => ProductInformationForm(
            categoryId: settings.arguments as int, // Pass the category ID
          ),
        );
      case ordersManagment:
        return MaterialPageRoute(builder: (_) => const OrdersManagmentScreen());
      case notifications:
        return MaterialPageRoute(builder: (_) => const NotificationsScreen());
      case analyticsHome:
        return MaterialPageRoute(builder: (_) => AnalyticsHomeScreen());
      case adminSettingsScreen:
        return MaterialPageRoute(builder: (_) => const AdminSettingsScreen());
      case adminHomeScreen:
        return MaterialPageRoute(builder: (_) => const AdminHomeScreen());
      case adminOrderDetailsScreen:
        return MaterialPageRoute(
          builder: (_) => const AdminOrderDetailsScreen(),
        );
      case customerLogin:
        return MaterialPageRoute(builder: (_) => const CustomerLoginScreen());
      case customerSignUp:
        return MaterialPageRoute(builder: (_) => const CustomerSignUpScreen());
      case forgetPassword:
        return MaterialPageRoute(
          builder: (_) => const CustomerForgetPasswordScreen(),
        );
      case customerHomeScreen:
        return MaterialPageRoute(builder: (_) => CustomerHomeScreen());
      default:
        return null;
    }
  }
}
