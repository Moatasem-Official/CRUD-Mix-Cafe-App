import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bussines_logic/cubits/customer/cart_screen/cubit/cart_screen_cubit.dart';
import '../../../data/helpers/custom_snack_bar.dart';
import '../../../data/helpers/when_loading_widget.dart';
import '../../widgets/customer/customer_cart_screen/custom_cart_item_container.dart';
import '../../widgets/customer/customer_cart_screen/custom_checkout_container.dart';

class CustomerCartScreen extends StatefulWidget {
  const CustomerCartScreen({super.key});

  @override
  State<CustomerCartScreen> createState() => _CustomerCartScreenState();
}

class _CustomerCartScreenState extends State<CustomerCartScreen> {
  Map<String, int> productQuantities = {};
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    context.read<CartScreenCubit>().getCartProducts().then((_) {
      final products = context.read<CartScreenCubit>().state;
      if (products is CartScreenSuccess) {
        setState(() {
          productQuantities = {
            for (var product in products.products) product.id: 1,
          };
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(
              255,
              255,
              253,
              251,
            ), // لون بيج فاتح
            automaticallyImplyLeading: false,
            elevation: 0,
            title: const Text(
              'Your Cart',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            surfaceTintColor: const Color.fromARGB(255, 255, 253, 251),
          ),
          backgroundColor: const Color.fromARGB(
            255,
            255,
            253,
            251,
          ), // لون بيج فاتح
          body: BlocConsumer<CartScreenCubit, CartScreenState>(
            listener: (context, state) {
              if (state is CartScreenError) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.error)));
              } else if (state is RemoveProductFromCart) {
                ScaffoldMessenger.of(context).showSnackBar(
                  CustomSnackBar(
                    title: 'Success',
                    message: state.message,
                    contentType: ContentType.success,
                  ),
                );
              } else if (state is OrdersReachedToMaxTimes) {
                setState(() {
                  isLoading = false;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  CustomSnackBar(
                    title: 'Limit Exceeded',
                    message: state.message,
                    contentType: ContentType.failure,
                  ),
                );
              } else if (state is RequestOrderSuccess) {
                setState(() {
                  isLoading = false;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  CustomSnackBar(
                    title: 'Success',
                    message: state.message,
                    contentType: ContentType.success,
                  ),
                );
              } else if (state is RequestOrderError) {
                setState(() {
                  isLoading = false;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  CustomSnackBar(
                    title: 'Error',
                    message: state.message,
                    contentType: ContentType.failure,
                  ),
                );
              } else if (state is RequestOrderLoading) {
                setState(() {
                  isLoading = true;
                });
              } else if (state is DuplicateOrder) {
                setState(() {
                  isLoading = false;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  CustomSnackBar(
                    title: 'Error',
                    message: state.message,
                    contentType: ContentType.failure,
                  ),
                );
              }
            },
            builder: (context, state) {
              final prices = context
                  .read<CartScreenCubit>()
                  .calculateTotalPrice(
                    state is CartScreenSuccess ? state.products : [],
                    productQuantities,
                  );
              return SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: state is CartScreenLoading
                            ? const Center(child: CircularProgressIndicator())
                            : state is CartScreenSuccess
                            ? state.products.isEmpty
                                  ? const Center(child: Text('Cart is Empty !'))
                                  : ListView.builder(
                                      itemCount: state.products.length,
                                      itemBuilder: (context, index) {
                                        final product = state.products[index];
                                        final quantity =
                                            productQuantities[product.id] ?? 1;
                                        return CustomCartItemContainer(
                                          product: product,
                                          productName: product.name,
                                          productPrice: product.hasDiscount
                                              ? product.discountedPrice
                                              : product.price,
                                          productImage: product.imageUrl,
                                          productQuantity: quantity,
                                          onAdd: () {
                                            setState(() {
                                              if (quantity < product.quantity) {
                                                final isAvailable =
                                                    product.isAvailable;
                                                final isInStock =
                                                    product.quantity > quantity;
                                                final hasValidDiscount =
                                                    product.hasDiscount &&
                                                    product.discountedPrice > 0;
                                                final isNormalProduct =
                                                    !product.hasDiscount;

                                                if (isAvailable &&
                                                    isInStock &&
                                                    (hasValidDiscount ||
                                                        isNormalProduct)) {
                                                  productQuantities[product
                                                          .id] =
                                                      quantity + 1;
                                                }
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                  ..hideCurrentSnackBar()
                                                  ..showSnackBar(
                                                    CustomSnackBar(
                                                      title: 'Out Of Stock',
                                                      message:
                                                          'Product Quantity Is Reached To Its Limit',
                                                      contentType:
                                                          ContentType.failure,
                                                    ),
                                                  );
                                              }
                                            });
                                          },
                                          onMinus: () {
                                            setState(() {
                                              if (quantity > 1) {
                                                productQuantities[product.id] =
                                                    quantity - 1;
                                              }
                                            });
                                          },
                                          onDelete: () {
                                            context
                                                .read<CartScreenCubit>()
                                                .removeProductFromCart(
                                                  product.id,
                                                );
                                          },
                                        );
                                      },
                                    )
                            : state is CartScreenError
                            ? Center(child: Text(state.error))
                            : Container(),
                      ),
                    ),
                    state is CartScreenSuccess && state.products.isNotEmpty
                        ? CustomCheckoutContainer(
                            subTotal: double.parse(
                              prices[1].toStringAsFixed(2),
                            ),
                            deliveryFee: double.parse(
                              prices[2].toStringAsFixed(2),
                            ),
                            total: double.parse(prices[0].toStringAsFixed(2)),
                            onCheckout: () {
                              final userId =
                                  FirebaseAuth.instance.currentUser!.uid;
                              context
                                  .read<CartScreenCubit>()
                                  .onCustomerRequestOrder(
                                    userId,
                                    prices,
                                    productQuantities,
                                    state.products,
                                  );
                            },
                          )
                        : Container(),
                  ],
                ),
              );
            },
          ),
        ),
        isLoading ? const WhenLoadingLogInWidget() : Container(),
      ],
    );
  }
}
