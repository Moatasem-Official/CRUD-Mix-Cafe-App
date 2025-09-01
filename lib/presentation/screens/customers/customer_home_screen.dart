import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mix_cafe_app/bussines_logic/cubits/customer/cart_screen/cubit/cart_screen_cubit.dart';
import 'package:mix_cafe_app/data/helpers/custom_snack_bar.dart';
import '../../../bussines_logic/cubits/customer/home_screen/cubit/home_screen_cubit.dart';
import '../../../data/services/firestore/firestore_services.dart';
import '../../widgets/customer/customer_home_screen/custom_scroll_view_widget.dart';
import '../../widgets/customer/customer_see_all_products/custom_product_card.dart';
import '../../widgets/customer/customer_home_screen/custom_app_bar.dart';
import '../../../data/services/auth/auth_service.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({super.key});

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  final AuthService authService = AuthService();
  final FirestoreServices firestoreServices = FirestoreServices();
  String selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    context.read<HomeScreenCubit>().getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartScreenCubit, CartScreenState>(
      listener: (context, state) {
        if (state is AddProductToCart) {
          ScaffoldMessenger.of(context).showSnackBar(
            CustomSnackBar(
              message: state.message,
              title: 'Success',
              contentType: ContentType.success,
            ),
          );
        } else if (state is AddProductToCartError) {
          ScaffoldMessenger.of(context).showSnackBar(
            CustomSnackBar(
              message: state.message,
              title: 'Error',
              contentType: ContentType.failure,
            ),
          );
        }
      },
      child: GestureDetector(
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
                      return ProductCard(
                        name: state.products[index].name,
                        price: state.products[index].price,
                        imageUrl: state.products[index].imageUrl,
                        product: state.products[index],
                        onAddToCart: () {
                          context.read<CartScreenCubit>().addProductToCart(
                            state.products[index],
                          );
                        },
                        discountPercentage: double.parse(
                          (100 -
                                  ((state.products[index].discountedPrice /
                                          state.products[index].price) *
                                      100))
                              .toStringAsFixed(2),
                        ),
                        hasDiscount: state.products[index].hasDiscount,
                        isAvailable: state.products[index].isAvailable,
                        quantity: state.products[index].quantity,
                        offerEndDate: state.products[index].endDiscount,
                        offerStartDate: state.products[index].startDiscount,
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
                      return ProductCard(
                        name: state.products[index].name,
                        price: state.products[index].price,
                        imageUrl: state.products[index].imageUrl,
                        product: state.products[index],
                        onAddToCart: () {
                          context.read<CartScreenCubit>().addProductToCart(
                            state.products[index],
                          );
                        },
                        discountPercentage: double.parse(
                          (100 -
                                  ((state.products[index].discountedPrice /
                                          state.products[index].price) *
                                      100))
                              .toStringAsFixed(2),
                        ),
                        hasDiscount: state.products[index].hasDiscount,
                        isAvailable: state.products[index].isAvailable,
                        quantity: state.products[index].quantity,
                        offerEndDate: state.products[index].endDiscount,
                        offerStartDate: state.products[index].startDiscount,
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
                  onAddToCart: (product) async {
                    print('Product added to cart: ${product.name}');
                    context.read<CartScreenCubit>().addProductToCart(product);
                  },
                );
              } else {
                return const Center(child: Text('Unknown state'));
              }
            },
          ),
        ),
      ),
    );
  }
}
