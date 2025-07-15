import 'package:flutter/material.dart';
import '../../widgets/customer/customer_home_screen/custom_app_bar.dart';
import '../../widgets/customer/customer_home_screen/custom_featured_items_list_view.dart';
import '../../widgets/customer/customer_home_screen/custom_items_title_row.dart';
import '../../../data/services/auth/auth_service.dart';

class CustomerHomeScreen extends StatelessWidget {
  CustomerHomeScreen({super.key});

  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(315),
        child: CustomAppBar(),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: CustomItemsTitleRow(title: 'Featured Items'),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: CustomFeaturedItemsListView(),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 20)),
          SliverToBoxAdapter(child: CustomItemsTitleRow(title: 'Best Sellers')),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: CustomFeaturedItemsListView(),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 20)),
          SliverToBoxAdapter(child: CustomItemsTitleRow(title: 'New Items')),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: CustomFeaturedItemsListView(),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
    );
  }
}
