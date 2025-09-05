import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mix_cafe_app/data/helpers/custom_snack_bar.dart';
import 'package:mix_cafe_app/data/helpers/when_loading_widget.dart';
import 'package:mix_cafe_app/presentation/widgets/customer/customer_orders_screen/custom_empty_orders.dart';
import '../../../data/helpers/search_helper.dart';
import '../../../bussines_logic/cubits/customer/orders_screen/cubit/orders_screen_cubit.dart';
import '../../../data/services/auth/auth_service.dart';
import '../../widgets/customer/customer_orders_screen/custom_app_bar.dart';
import '../../widgets/customer/customer_orders_screen/custom_order_card.dart';

class CustomerOrdersScreen extends StatefulWidget {
  const CustomerOrdersScreen({super.key});

  @override
  State<CustomerOrdersScreen> createState() => _CustomerOrdersScreenState();
}

class _CustomerOrdersScreenState extends State<CustomerOrdersScreen> {
  @override
  void initState() {
    super.initState();
    context.read<OrdersScreenCubit>().getOrders();
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocListener<OrdersScreenCubit, OrdersScreenState>(
          listener: (context, state) {
            if (state is ReorderLoading) {
              setState(() {
                isLoading = true;
              });
            } else if (state is ReorderSuccess) {
              setState(() {
                isLoading = false;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                CustomSnackBar(
                  message: state.message,
                  title: 'Success',
                  contentType: ContentType.success,
                ),
              );
            } else if (state is ReorderError) {
              setState(() {
                isLoading = false;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                CustomSnackBar(
                  message: state.message,
                  title: 'Error',
                  contentType: ContentType.failure,
                ),
              );
            } else if (state is ReoderedOrdersReachedToMaxTimes) {
              setState(() {
                isLoading = false;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                CustomSnackBar(
                  message: state.message,
                  title: 'Error',
                  contentType: ContentType.failure,
                ),
              );
            } else if (state is CancelOrderLoading) {
              setState(() {
                isLoading = true;
              });
            } else if (state is CancelOrderSuccess) {
              setState(() {
                isLoading = false;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                CustomSnackBar(
                  message: state.message,
                  title: 'Success',
                  contentType: ContentType.success,
                ),
              );
            } else if (state is CancelOrderError) {
              setState(() {
                isLoading = false;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                CustomSnackBar(
                  message: state.message,
                  title: 'Error',
                  contentType: ContentType.failure,
                ),
              );
            }
          },
          child: Scaffold(
            backgroundColor: const Color.fromARGB(255, 255, 253, 251),
            body: CustomScrollView(
              slivers: [
                CustomerOrdersSliverAppBar(
                  onFilterChanged: (index) {
                    final AuthService authService = AuthService();
                    index == 0
                        ? context.read<OrdersScreenCubit>().getOrders()
                        : index == 1
                        ? context
                              .read<OrdersScreenCubit>()
                              .filterOrdersByStatus(
                                authService.currentUser!.uid,
                                'pending',
                              )
                        : index == 2
                        ? context
                              .read<OrdersScreenCubit>()
                              .filterOrdersByStatus(
                                authService.currentUser!.uid,
                                'delivered',
                              )
                        : index == 3
                        ? context
                              .read<OrdersScreenCubit>()
                              .filterOrdersByStatus(
                                authService.currentUser!.uid,
                                'cancelled',
                              )
                        : null;
                  },
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 20)),
                // 2. The list of orders
                BlocBuilder<OrdersScreenCubit, OrdersScreenState>(
                  builder: (context, state) {
                    if (state is OrdersScreenLoading) {
                      return SliverToBoxAdapter(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height - 200,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Color.fromARGB(255, 165, 101, 56),
                            ),
                          ),
                        ),
                      );
                    } else if (state is OrdersScreenSuccess) {
                      if (state.orders.isEmpty) {
                        return SliverToBoxAdapter(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height - 200,
                            child: Center(
                              child: SizedBox(
                                width: 300,
                                child: CustomEmptyOrders(),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return SliverList(
                          delegate: SliverChildBuilderDelegate((
                            context,
                            index,
                          ) {
                            final order = state.orders[index]; // OrderModel
                            for (var item in order.items!) {
                              print(item['name']); // أو أي مفتاح آخر
                            }

                            return OrderCard(
                              orderCount: '${index + 1}',
                              orderId: order.orderId!,
                              userId: order.userId!,
                              preparingTime: order.preparationTime!.isNotEmpty
                                  ? SearchHelper.formatPreparedTime(
                                      order.preparationTime!,
                                    )
                                  : 'Not Prepared Yet',
                              date: order.timestamp.toString().split(' ')[0],
                              status: order.status!,
                              totalPrice: order.totalPrice!,
                              products: order.items!,
                            );
                          }, childCount: state.orders.length),
                        );
                      }
                    } else if (state is OrdersScreenFilterOrders) {
                      print(state.orders.length);
                      if (state.orders.isEmpty) {
                        return SliverToBoxAdapter(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height - 200,
                            child: Center(
                              child: SizedBox(
                                width: 300,
                                child: CustomEmptyOrders(),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return SliverList(
                          delegate: SliverChildBuilderDelegate((
                            context,
                            index,
                          ) {
                            final order = state.orders[index]; // OrderModel

                            return OrderCard(
                              orderCount: '${index + 1}',
                              orderId: order.orderId!,
                              userId: order.userId!,
                              preparingTime: order.preparationTime!.isNotEmpty
                                  ? SearchHelper.formatPreparedTime(
                                      order.preparationTime!,
                                    )
                                  : 'Not Prepared Yet',
                              date:
                                  order.timestamp?.toString().split(' ')[0] ??
                                  '',
                              status: order.status ?? '',
                              totalPrice: order.totalPrice ?? 0,
                              products: order.items ?? [],
                            );
                          }, childCount: state.orders.length),
                        );
                      }
                    } else if (state is OrdersScreenError) {
                      return SliverToBoxAdapter(
                        child: Center(child: Text(state.message)),
                      );
                    } else {
                      return const SliverToBoxAdapter(child: SizedBox.shrink());
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        isLoading ? WhenLoadingLogInWidget() : const SizedBox.shrink(),
      ],
    );
  }
}
