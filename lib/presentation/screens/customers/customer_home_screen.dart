import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mix_cafe_app/bussines_logic/cubits/customer/home_screen/cubit/home_screen_cubit.dart';
import 'package:mix_cafe_app/presentation/widgets/customer/customer_home_screen/custom_scroll_view_widget.dart';
import 'package:mix_cafe_app/presentation/widgets/customer/customer_see_all_products/custom_product_card.dart';
import '../../widgets/customer/customer_home_screen/custom_app_bar.dart';
import '../../../data/services/auth/auth_service.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({super.key});

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  final AuthService authService = AuthService();
  String selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeScreenCubit>().getProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(315),
          child: CustomAppBar(
            onSearchChanged: (value) {
              value.isNotEmpty
                  ? context.read<HomeScreenCubit>().searchProducts(value)
                  : context.read<HomeScreenCubit>().getProducts();
            },
            selectedFilter: selectedCategory,
            onFilterAllTapped: () {
              setState(() {
                selectedCategory = 'All';
              });
              context.read<HomeScreenCubit>().getProducts();
            },
            onFilterSandwichesTapped: () {
              setState(() {
                selectedCategory = 'Sandwiches';
              });
              context.read<HomeScreenCubit>().filterProducts('Sandwichs');
            },
            onFilterPizzasTapped: () {
              setState(() {
                selectedCategory = 'Pizzas';
              });
              context.read<HomeScreenCubit>().filterProducts('Pizzas');
            },
            onFilterCrepesTapped: () {
              setState(() {
                selectedCategory = 'Crepes';
              });
              context.read<HomeScreenCubit>().filterProducts('Crepes');
            },
            onFilterMealsTapped: () {
              setState(() {
                selectedCategory = 'Meals';
              });
              context.read<HomeScreenCubit>().filterProducts('Meals');
            },
            onFilterDesertsTapped: () {
              setState(() {
                selectedCategory = 'Deserts';
              });
              context.read<HomeScreenCubit>().filterProducts('Deserts');
            },
            onFilterDrinksTapped: () {
              setState(() {
                selectedCategory = 'Drinks';
              });
              context.read<HomeScreenCubit>().filterProducts('Drinks');
            },
          ),
        ),
        body: BlocBuilder<HomeScreenCubit, HomeScreenState>(
          builder: (context, state) {
            if (state is HomeScreenLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HomeScreenError) {
              return Center(child: Text(state.error));
            } else if (state is HomeScreenSearch) {
              if (state.products.isEmpty) {
                return const Center(child: Text('No products available.'));
              } else {
                return ListView.builder(
                  itemCount: state.products.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () => Navigator.pushNamed(
                        context,
                        '/customerShowProductDetails',
                        arguments: state.products[index],
                      ),
                      child: ProductCard(
                        name: state.products[index].name,
                        description: state.products[index].description,
                        price: state.products[index].price,
                        imageUrl: state.products[index].imageUrl,
                      ),
                    );
                  },
                );
              }
            } else if (state is HomeScreenFilter) {
              if (state.products.isEmpty) {
                return const Center(child: Text('No products available.'));
              } else {
                return ListView.builder(
                  itemCount: state.products.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () => Navigator.pushNamed(
                        context,
                        '/customerShowProductDetails',
                        arguments: state.products[index],
                      ),
                      child: ProductCard(
                        name: state.products[index].name,
                        description: state.products[index].description,
                        price: state.products[index].price,
                        imageUrl: state.products[index].imageUrl,
                      ),
                    );
                  },
                );
              }
            } else if (state is HomeScreenSuccess) {
              return CustomScrollViewWidget(
                featuredProducts: context
                    .read<HomeScreenCubit>()
                    .featuredProducts,
                bestProducts: context.read<HomeScreenCubit>().bestProducts,
                newProducts: context.read<HomeScreenCubit>().newProducts,
                otherProducts: context.read<HomeScreenCubit>().otherProducts,
              );
            } else {
              return const Center(child: Text('Unknown state'));
            }
          },
        ),
      ),
    );
  }
}
