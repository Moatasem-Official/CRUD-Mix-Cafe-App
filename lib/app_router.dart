import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mix_cafe_app/bussines_logic/cubits/customer/home_screen/cubit/home_screen_cubit.dart';
import 'package:mix_cafe_app/presentation/screens/customers/customer_home_navigation.dart';
import 'package:mix_cafe_app/presentation/screens/customers/customer_orders_screen.dart';
import 'package:mix_cafe_app/presentation/screens/customers/customer_see_all_products_screen.dart';
import 'bussines_logic/cubits/admin/login_screen/cubit/log_in_cubit_cubit.dart';
import 'bussines_logic/cubits/customer/Login_Screen/cubit/login_cubit.dart';
import 'bussines_logic/cubits/customer/SignUp_Screen/cubit/sign_up_cubit.dart';
import 'bussines_logic/cubits/customer/forget_password_screen/cubit/forget_password_cubit.dart';
import 'presentation/screens/customers/customer_cart_screen.dart';
import 'presentation/screens/customers/customer_profile_screen.dart';
import 'presentation/screens/customers/customer_show_product_screen.dart';
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
  static const String customerProfileScreen = '/customerProfileScreen';
  static const String customerCartScreen = '/customerCartScreen';
  static const String customerShowProductDetails =
      '/customerShowProductDetails';
  static const String customerSeeAllProductsScreen =
      '/customerSeeAllProductsScreen';
  static const String customerOrdersScreen = '/customerOrdersScreen';
  static const String customerHomeNavigation = '/customerHomeNavigation';

  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case selectUserRole:
        return MaterialPageRoute(builder: (_) => const SelectUserRoleScreen());
      case adminLogin:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<LogInCubitCubit>(
            create: (context) => LogInCubitCubit(),
            child: AdminLoginScreen(),
          ),
        );
      case categoriesManagment:
        return MaterialPageRoute(builder: (_) => CategoriesManagmentScreen());
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
        return MaterialPageRoute(
          builder: (_) => BlocProvider<LoginCubit>(
            create: (context) => LoginCubit(),
            child: CustomerLoginScreen(),
          ),
        );
      case customerSignUp:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<SignUpCubit>(
            create: (context) => SignUpCubit(),
            child: CustomerSignUpScreen(),
          ),
        );
      case forgetPassword:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<ForgetPasswordCubit>(
            create: (context) => ForgetPasswordCubit(),
            child: CustomerForgetPasswordScreen(),
          ),
        );
      case customerHomeScreen:
        return MaterialPageRoute(builder: (_) => CustomerHomeScreen());
      case customerProfileScreen:
        return MaterialPageRoute(builder: (_) => const CustomerProfileScreen());
      case customerCartScreen:
        return MaterialPageRoute(builder: (_) => const CustomerCartScreen());
      case customerShowProductDetails:
        return MaterialPageRoute(
          builder: (_) =>
              const CustomerShowProductScreen(), // Placeholder for product details
        );
      case customerSeeAllProductsScreen:
        return MaterialPageRoute(
          builder: (_) => const CustomerSeeAllProductsScreen(),
        );
      case customerOrdersScreen:
        return MaterialPageRoute(builder: (_) => const CustomerOrdersScreen());
      case customerHomeNavigation:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<HomeScreenCubit>(
            create: (_) => HomeScreenCubit()..getProducts(),
            child: const CustomerHomeNavigation(),
          ),
        );
      default:
        return null;
    }
  }
}
