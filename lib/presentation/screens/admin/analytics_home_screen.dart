import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mix_cafe_app/bussines_logic/cubits/admin/analytics_home_screen/cubit/home_analytics_cubit.dart';
import '../../widgets/admin/Analytics_Home_Screen_Widgets/custom_analysis_containers_row.dart';
import '../../widgets/admin/Analytics_Home_Screen_Widgets/custom_notifications_num.dart';
import '../../../constants/app_assets.dart';
import '../../widgets/admin/Analytics_Home_Screen_Widgets/analytics_chart.dart';
import '../../widgets/admin/Analytics_Home_Screen_Widgets/custom_most_popular_items_grid.dart';
import '../../widgets/admin/Analytics_Home_Screen_Widgets/custom_title_of_popular_items.dart';

class AnalyticsHomeScreen extends StatefulWidget {
  const AnalyticsHomeScreen({super.key});

  @override
  State<AnalyticsHomeScreen> createState() => _AnalyticsHomeScreenState();
}

class _AnalyticsHomeScreenState extends State<AnalyticsHomeScreen> {
  List<Map<String, dynamic>> data = [
    {
      'imagePath': Assets.mixCafeAdminImage,
      'name': 'Cappuccino',
      'description':
          'Cappuccino is a coffee drink made from espresso and steamed milk, typically topped with a steamed milk foam.',
      'price': 2.99,
    },
    {
      'imagePath': Assets.mixCafeCustomerImage,
      'name': 'Latte',
      'description':
          'Latte is a coffee drink made from espresso steamed milk foam.',
      'price': 3.99,
    },
    {
      'imagePath': Assets.mixCafeImageLogo,
      'name': 'Espresso',
      'description':
          'Espresso is a coffee drink made from espresso and steamed milk, typically topped with foam.',
      'price': 2.49,
    },
    {
      'imagePath': Assets.mixCafeAdminImage,
      'name': 'Cafe',
      'description': 'Cafe spressofoam is a coffee drink made from espresso.',
      'price': 1.99,
    },
  ];

  @override
  void initState() {
    super.initState();
    context.read<HomeAnalyticsCubit>().getAnalytics();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        surfaceTintColor: Colors.white,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: const Text(
          'Mix Cafe Admin',
          style: TextStyle(
            color: Color.fromARGB(255, 165, 101, 56),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        actions: [
          IconButton(
            tooltip: 'Notifications',
            style: ButtonStyle(
              overlayColor: WidgetStateProperty.all(Colors.transparent),
            ),
            onPressed: () => Navigator.of(context).pushNamed('/notifications'),
            icon: CustomNotificationsNumStack(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            BlocBuilder<HomeAnalyticsCubit, HomeAnalyticsState>(
              builder: (context, state) {
                if (state is HomeAnalyticsLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is HomeAnalyticsSuccess) {
                  return CustomAnalysisContainersRow(
                    ordersNumber: state.analyticsData[0].toString(),
                    usersNumber: state.analyticsData[2].toString(),
                    salesNumber: state.analyticsData[1].toString(),
                  );
                } else if (state is HomeAnalyticsError) {
                  return Text(state.message);
                } else {
                  return const Text('Unknown state');
                }
              },
            ),
            CustomAnalysisChart(),
            CustomTitleOfPopularItems(),
            CustomMostPopularItemsGrid(items: data),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
