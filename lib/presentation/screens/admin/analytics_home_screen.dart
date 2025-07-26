import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mix_cafe_app/bussines_logic/cubits/admin/analytics_home_screen/chart_cubit/cubit/chart_distributions_analysis_cubit.dart';
import 'package:mix_cafe_app/bussines_logic/cubits/admin/analytics_home_screen/cubit/home_analytics_cubit.dart';
import 'package:mix_cafe_app/bussines_logic/cubits/customer/home_screen/cubit/home_screen_cubit.dart';
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
  @override
  void initState() {
    super.initState();
    context.read<HomeAnalyticsCubit>().getAnalytics();
    context.read<ChartDistributionsAnalysisCubit>().getAnalyticsDistribution();
    context.read<HomeScreenCubit>().getProducts();
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
            CustomAnalysisContainersRow(),
            CustomAnalysisChart(),
            CustomTitleOfPopularItems(
              items: context.read<HomeScreenCubit>().bestProducts,
            ),
            BlocBuilder<HomeScreenCubit, HomeScreenState>(
              builder: (context, state) {
                if (state is HomeScreenLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Color.fromARGB(255, 165, 101, 56),
                    ),
                  );
                } else if (state is HomeScreenSuccess) {
                  final items = context.read<HomeScreenCubit>().bestProducts;

                  if (items.isEmpty) {
                    return const Center(child: Text('No popular items found.'));
                  } else {
                    return CustomMostPopularItemsGrid(items: items);
                  }
                } else if (state is HomeScreenError) {
                  return const Center(
                    child: Text('Error loading popular items.'),
                  );
                } else {
                  return Container();
                }
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
