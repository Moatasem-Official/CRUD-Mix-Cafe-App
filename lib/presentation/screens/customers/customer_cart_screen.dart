import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mix_cafe_app/bussines_logic/cubits/customer/cart_screen/cubit/cart_screen_cubit.dart';
import 'package:mix_cafe_app/data/helpers/custom_snack_bar.dart';
import 'package:mix_cafe_app/data/helpers/when_loading_widget.dart';
import 'package:mix_cafe_app/data/services/firestore/firestore_services.dart';
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
                                                      title: 'Out of Stock',
                                                      message:
                                                          'This product is out of stock',
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
                            onCheckout: () async {
                              setState(() {
                                isLoading = true;
                              });

                              final firestore = FirebaseFirestore.instance;
                              final userId =
                                  FirebaseAuth.instance.currentUser!.uid;
                              final todayStart = Timestamp.fromDate(
                                DateTime(
                                  DateTime.now().year,
                                  DateTime.now().month,
                                  DateTime.now().day,
                                ),
                              );

                              final todayEnd = Timestamp.fromDate(
                                DateTime(
                                  DateTime.now().year,
                                  DateTime.now().month,
                                  DateTime.now().day,
                                  23,
                                  59,
                                  59,
                                ),
                              );

                              // تحقق من عدد الطلبات في نفس اليوم
                              final ordersQuery = await firestore
                                  .collection('users')
                                  .doc(userId)
                                  .collection('orders')
                                  .where(
                                    'timestamp',
                                    isGreaterThanOrEqualTo: todayStart,
                                  )
                                  .where(
                                    'timestamp',
                                    isLessThanOrEqualTo: todayEnd,
                                  )
                                  .get();

                              if (ordersQuery.docs.length >= 5) {
                                setState(() {
                                  isLoading = false;
                                });
                                // عرض رسالة مثلاً
                                ScaffoldMessenger.of(context)
                                  ..hideCurrentSnackBar()
                                  ..showSnackBar(
                                    CustomSnackBar(
                                      message:
                                          'You have reached the maximum number of orders for today. Please try again tomorrow.',
                                      title: 'Day Orders Limit Reached',
                                      contentType: ContentType.failure,
                                    ),
                                  );
                                return;
                              }

                              // لو الطلب مسموح
                              final FirestoreServices firestoreServices =
                                  FirestoreServices();
                              await firestoreServices.addOrder(
                                userId,
                                double.parse(prices[0].toStringAsFixed(2)),
                                state.products
                                    .map(
                                      (product) => {
                                        'productId': product.id,
                                        'orderItems': [
                                          {
                                            'quantity':
                                                productQuantities[product.id],
                                            'price': product.hasDiscount
                                                ? product.discountedPrice
                                                : product.price,
                                            'name': product.name,
                                            'imageUrl': product.imageUrl,
                                          },
                                        ],
                                      },
                                    )
                                    .toList(),
                              );

                              setState(() {
                                isLoading = false;
                              });
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
