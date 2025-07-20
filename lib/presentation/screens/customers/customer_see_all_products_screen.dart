import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mix_cafe_app/bussines_logic/cubits/customer/see_all_products_screen/cubit/see_all_products_cubit.dart';
import 'package:mix_cafe_app/data/model/product_model.dart';
import 'package:mix_cafe_app/data/services/auth/auth_service.dart';
import 'package:mix_cafe_app/data/services/firestore/firestore_services.dart';
import 'package:mix_cafe_app/presentation/widgets/customer/customer_see_all_products/custom_product_card.dart';

class CustomerSeeAllProductsScreen extends StatefulWidget {
  const CustomerSeeAllProductsScreen({super.key, required this.products});

  final List<ProductModel> products;

  @override
  State<CustomerSeeAllProductsScreen> createState() =>
      _CustomerSeeAllProductsScreenState();
}

class _CustomerSeeAllProductsScreenState
    extends State<CustomerSeeAllProductsScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<SeeAllProductsCubit>().showAllProducts(widget.products);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomerAppBar(
        searchController: searchController,
        onSearchPressed: () {
          context.read<SeeAllProductsCubit>().searchProducts(
            searchController.text,
            widget.products,
          );
        },
      ),
      backgroundColor: const Color.fromARGB(255, 255, 253, 251),
      body: SingleChildScrollView(
        child: BlocBuilder<SeeAllProductsCubit, SeeAllProductsState>(
          builder: (context, state) {
            if (state is SeeAllProductsLoading) {
              return SizedBox(
                height:
                    MediaQuery.of(context).size.height - kToolbarHeight - 60,
                child: const Center(child: CircularProgressIndicator()),
              );
            } else if (state is SeeAllProductsLoaded) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: widget.products.length,
                      itemBuilder: (context, index) {
                        final FirestoreServices firestoreServices =
                            FirestoreServices();
                        final AuthService authService = AuthService();
                        return InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () => Navigator.pushNamed(
                            context,
                            '/customerShowProductDetails',
                            arguments: widget.products[index],
                          ),
                          child: ProductCard(
                            name: widget.products[index].name,
                            description: widget.products[index].description,
                            price: widget.products[index].price,
                            imageUrl: widget.products[index].imageUrl,
                            product: widget.products[index],
                            onAddToCart: () =>
                                firestoreServices.addProductToCart(
                                  widget.products[index],
                                  authService.currentUser!.uid,
                                ),
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
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            } else if (state is SeeAllProductsSearch) {
              if (state.searchResults.isEmpty) {
                return SizedBox(
                  height:
                      MediaQuery.of(context).size.height - kToolbarHeight - 60,
                  child: const Center(child: Text('No results found!')),
                );
              } else {
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.searchResults.length,
                          itemBuilder: (context, index) {
                            final FirestoreServices firestoreServices =
                                FirestoreServices();
                            final AuthService authService = AuthService();
                            return InkWell(
                              borderRadius: BorderRadius.circular(10),
                              onTap: () => Navigator.pushNamed(
                                context,
                                '/customerShowProductDetails',
                                arguments: state.searchResults[index],
                              ),
                              child: ProductCard(
                                name: state.searchResults[index].name,
                                description:
                                    state.searchResults[index].description,
                                price: state.searchResults[index].price,
                                imageUrl: state.searchResults[index].imageUrl,
                                product: state.searchResults[index],
                                onAddToCart: () =>
                                    firestoreServices.addProductToCart(
                                      state.searchResults[index],
                                      authService.currentUser!.uid,
                                    ),
                                discountPercentage: double.parse(
                                  (100 -
                                          ((state
                                                      .searchResults[index]
                                                      .discountedPrice /
                                                  state
                                                      .searchResults[index]
                                                      .price) *
                                              100))
                                      .toStringAsFixed(2),
                                ),
                                hasDiscount:
                                    state.searchResults[index].hasDiscount,
                                isAvailable:
                                    state.searchResults[index].isAvailable,
                                quantity: state.searchResults[index].quantity,
                                offerStartDate:
                                    state.searchResults[index].startDiscount,
                                offerEndDate:
                                    state.searchResults[index].endDiscount,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }
            } else if (state is SeeAllProductsError) {
              return Center(child: Text(state.message));
            } else {
              return const Center(child: Text('Something went wrong!'));
            }
          },
        ),
      ),
    );
  }
}

class CustomerAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomerAppBar({
    super.key,
    required this.searchController,
    required this.onSearchPressed,
  });

  final TextEditingController searchController;
  final Function() onSearchPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 255, 253, 251), // لون بيج فاتح
      elevation: 0,
      title: const Text(
        'All Products',
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      surfaceTintColor: const Color.fromARGB(255, 255, 253, 251),
      automaticallyImplyLeading: true,
      iconTheme: const IconThemeData(color: Colors.black),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Container(
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search Products...',
                hintStyle: TextStyle(color: Colors.grey[600]),
                border: InputBorder.none,
                prefixIcon: Icon(Icons.search, color: Colors.grey[700]),
              ),
              onChanged: (value) => onSearchPressed(),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(130);
}
