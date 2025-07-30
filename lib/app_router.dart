import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mix_cafe_app/presentation/screens/admin/add_offer_screen.dart';
import 'package:mix_cafe_app/presentation/screens/admin/offers_screen.dart';
import 'bussines_logic/cubits/admin/analytics_home_screen/chart_cubit/cubit/chart_distributions_analysis_cubit.dart';
import 'bussines_logic/cubits/admin/analytics_home_screen/cubit/home_analytics_cubit.dart';
import 'bussines_logic/cubits/admin/order_details_screen/cubit/order_details_screen_cubit.dart';
import 'bussines_logic/cubits/admin/orders_management_screen/cubit/orders_management_cubit.dart';
import 'bussines_logic/cubits/customer/cart_screen/cubit/cart_screen_cubit.dart';
import 'bussines_logic/cubits/customer/home_screen/cubit/home_screen_cubit.dart';
import 'bussines_logic/cubits/customer/orders_screen/cubit/orders_screen_cubit.dart';
import 'bussines_logic/cubits/customer/see_all_products_screen/cubit/see_all_products_cubit.dart';
import 'data/model/product_model.dart';
import 'presentation/screens/customers/about_mix_cafe_screen.dart';
import 'presentation/screens/customers/contact_support_screen.dart';
import 'presentation/screens/customers/customer_home_navigation.dart';
import 'presentation/screens/customers/customer_orders_screen.dart';
import 'presentation/screens/customers/customer_see_all_products_screen.dart';
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
  static const String adminAddOfferScreen = '/adminAddOfferScreen';
  static const String offersScreen = '/offersScreen';
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
  static const String aboutMixCafeScreen = '/aboutMixCafeScreen';
  static const String contactSupportScreen = '/contactSupportScreen';
  static const String orderDetailsScreen = '/orderDetailsScreen';

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
        return MaterialPageRoute(
          builder: (_) => BlocProvider<HomeAnalyticsCubit>(
            create: (context) => HomeAnalyticsCubit(),
            child: AnalyticsHomeScreen(),
          ),
        );
      case adminSettingsScreen:
        return MaterialPageRoute(builder: (_) => const AdminSettingsScreen());
      case adminHomeScreen:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<OrdersManagementCubit>(
                create: (context) => OrdersManagementCubit()..fetchOrders(),
              ),
              BlocProvider<HomeAnalyticsCubit>(
                create: (context) => HomeAnalyticsCubit(),
                child: AnalyticsHomeScreen(),
              ),
              BlocProvider<HomeScreenCubit>(
                create: (context) => HomeScreenCubit()..getProducts(),
              ),
              BlocProvider<ChartDistributionsAnalysisCubit>(
                create: (context) =>
                    ChartDistributionsAnalysisCubit()
                      ..getAnalyticsDistribution(),
              ),
              BlocProvider<OrderDetailsScreenCubit>(
                create: (context) => OrderDetailsScreenCubit(),
              ),
            ],
            child: const AdminHomeScreen(),
          ),
        );
      case adminOrderDetailsScreen:
        final arg = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => BlocProvider<OrderDetailsScreenCubit>(
            create: (context) => OrderDetailsScreenCubit(),
            child: AdminOrderDetailsScreen(
              order: arg['order'],
              orderId: arg['id'],
            ),
          ),
        );
      case adminAddOfferScreen:
        return MaterialPageRoute(builder: (_) => AdminAddOfferScreen());
      case offersScreen:
        return MaterialPageRoute(builder: (_) => OffersScreen());
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
        return MaterialPageRoute(
          builder: (_) => BlocProvider<CartScreenCubit>(
            create: (context) => CartScreenCubit(),
            child: const CustomerCartScreen(),
          ),
        );
      case customerShowProductDetails:
        final ProductModel product = settings.arguments as ProductModel;
        return MaterialPageRoute(
          builder: (_) => CustomerShowProductScreen(
            productModel: product,
          ), // Placeholder for product details
        );
      case customerSeeAllProductsScreen:
        final List<ProductModel> allCategoryProducts =
            settings.arguments as List<ProductModel>;
        return MaterialPageRoute(
          builder: (_) => BlocProvider<SeeAllProductsCubit>(
            create: (context) => SeeAllProductsCubit(),
            child: CustomerSeeAllProductsScreen(products: allCategoryProducts),
          ),
        );
      case customerOrdersScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<OrdersScreenCubit>(
            create: (context) => OrdersScreenCubit(),
            child: const CustomerOrdersScreen(),
          ),
        );
      case customerHomeNavigation:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<HomeScreenCubit>(
                create: (context) => HomeScreenCubit()..getProducts(),
              ),
              BlocProvider<CartScreenCubit>(
                create: (context) => CartScreenCubit()..getCartProducts(),
              ),
              BlocProvider<OrdersScreenCubit>(
                create: (context) => OrdersScreenCubit()..getOrders(),
              ),
            ],
            child: const CustomerHomeNavigation(),
          ),
        );
      case aboutMixCafeScreen:
        return MaterialPageRoute(builder: (_) => const AboutMixCafeScreen());
      case contactSupportScreen:
        return MaterialPageRoute(builder: (_) => const ContactSupportScreen());
      default:
        return null;
    }
  }
}
