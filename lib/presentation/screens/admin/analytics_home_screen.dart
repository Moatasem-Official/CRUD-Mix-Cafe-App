import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mix_cafe_app/constants/app_images.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/analytics_chart.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/custom_most_popular_items_grid.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/custom_analysis_container.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/custom_title_of_popular_items.dart';

class AnalyticsHomeScreen extends StatelessWidget {
  const AnalyticsHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        surfaceTintColor: Colors.white,
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white,
        title: const Text(
          'Mix Cafe Admin',
          style: TextStyle(
            color: Color(0xFF6F4E37),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        actions: [
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 237, 237, 237),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.notifications, color: Color(0xFF6F4E37)),
            ),
            onPressed: () => Navigator.of(context).pushNamed('/notifications'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
              child: Row(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomAnalysisContainer(
                    icon: FontAwesomeIcons.cartShopping,
                    analysisNumber: '1,000',
                    title: 'Orders',
                  ),
                  CustomAnalysisContainer(
                    icon: FontAwesomeIcons.chartBar,
                    analysisNumber: '1,000 \$',
                    title: 'Sales',
                  ),
                  CustomAnalysisContainer(
                    icon: FontAwesomeIcons.users,
                    analysisNumber: '1,000',
                    title: 'Users',
                  ),
                ],
              ),
            ),
            CustomAnalysisChart(),
            CustomTitleOfPopularItems(),
            CustomMostPopularItemsGrid(
              name: 'Cappuccino',
              description:
                  'Cappuccino is a coffee drink with espresso and steamed milk.',
              price: '25.00',
              imagePath: Assets.mixCafeAdminImage,
            ),
          ],
        ),
      ),
    );
  }
}
