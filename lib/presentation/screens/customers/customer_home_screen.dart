import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mix_cafe_app/bussines_logic/cubits/customer/home_screen/cubit/home_screen_cubit.dart';
import '../../widgets/customer/customer_home_screen/custom_app_bar.dart';
import '../../widgets/customer/customer_home_screen/custom_items_horizontal_list_view.dart';
import '../../widgets/customer/customer_home_screen/custom_items_title_row.dart';
import '../../../data/services/auth/auth_service.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({super.key});

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeScreenCubit>().getProducts();
    });
  }

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
              child: BlocBuilder<HomeScreenCubit, HomeScreenState>(
                builder: (context, state) {
                  if (state is HomeScreenLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is HomeScreenSuccess) {
                    if (context
                        .read<HomeScreenCubit>()
                        .featuredProducts
                        .isEmpty) {
                      return const Center(
                        child: Text('No products available.'),
                      );
                    }
                    return CustomItemsHorizontalListView(
                      products: context
                          .read<HomeScreenCubit>()
                          .featuredProducts,
                    );
                  } else if (state is HomeScreenError) {
                    return Center(child: Text(state.error));
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 20)),
          SliverToBoxAdapter(child: CustomItemsTitleRow(title: 'Best Sellers')),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: BlocBuilder<HomeScreenCubit, HomeScreenState>(
                builder: (context, state) {
                  if (state is HomeScreenLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is HomeScreenSuccess) {
                    if (context.read<HomeScreenCubit>().bestProducts.isEmpty) {
                      return const Center(
                        child: Text('No products available.'),
                      );
                    }
                    return CustomItemsHorizontalListView(
                      products: context.read<HomeScreenCubit>().bestProducts,
                    );
                  } else if (state is HomeScreenError) {
                    return Center(child: Text(state.error));
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 20)),
          SliverToBoxAdapter(child: CustomItemsTitleRow(title: 'New Items')),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: BlocBuilder<HomeScreenCubit, HomeScreenState>(
                builder: (context, state) {
                  if (state is HomeScreenLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is HomeScreenSuccess) {
                    if (context.read<HomeScreenCubit>().newProducts.isEmpty) {
                      return const Center(
                        child: Text('No products available.'),
                      );
                    }
                    return CustomItemsHorizontalListView(
                      products: context.read<HomeScreenCubit>().newProducts,
                    );
                  } else if (state is HomeScreenError) {
                    return Center(child: Text(state.error));
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 20)),
          SliverToBoxAdapter(child: CustomItemsTitleRow(title: 'Other Items')),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: BlocBuilder<HomeScreenCubit, HomeScreenState>(
                builder: (context, state) {
                  if (state is HomeScreenLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is HomeScreenSuccess) {
                    if (context.read<HomeScreenCubit>().otherProducts.isEmpty) {
                      return const Center(
                        child: Text('No products available.'),
                      );
                    }
                    return CustomItemsHorizontalListView(
                      products: context.read<HomeScreenCubit>().otherProducts,
                    );
                  } else if (state is HomeScreenError) {
                    return Center(child: Text(state.error));
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
    );
  }
}
