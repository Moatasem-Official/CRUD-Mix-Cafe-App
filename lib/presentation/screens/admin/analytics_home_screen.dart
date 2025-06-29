import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mix_cafe_app/constants/app_images.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/Analytics_Home_Screen_Widgets/analytics_chart.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/Analytics_Home_Screen_Widgets/custom_most_popular_items_grid.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/Analytics_Home_Screen_Widgets/custom_analysis_container.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/Analytics_Home_Screen_Widgets/custom_title_of_popular_items.dart';

class AnalyticsHomeScreen extends StatelessWidget {
  AnalyticsHomeScreen({super.key});

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
            color: Color.fromARGB(255, 165, 101, 56),
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
              child: const Icon(
                Icons.notifications,
                color: Color.fromARGB(255, 165, 101, 56),
              ),
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
            CustomMostPopularItemsGrid(items: data),
          ],
        ),
      ),
    );
  }
}
