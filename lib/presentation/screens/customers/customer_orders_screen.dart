import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 253, 251),
      body: CustomScrollView(
        slivers: [
          // 1. Your new "fantastic" SliverAppBar
          CustomerOrdersSliverAppBar(
            onFilterChanged: (index) {
              final AuthService authService = AuthService();
              index == 0
                  ? context.read<OrdersScreenCubit>().getOrders()
                  : index == 1
                  ? context.read<OrdersScreenCubit>().filterOrdersByStatus(
                      authService.currentUser!.uid,
                      'pending',
                    )
                  : index == 2
                  ? context.read<OrdersScreenCubit>().filterOrdersByStatus(
                      authService.currentUser!.uid,
                      'delivered',
                    )
                  : index == 3
                  ? context.read<OrdersScreenCubit>().filterOrdersByStatus(
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
                    child: Center(child: CircularProgressIndicator()),
                  ),
                );
              } else if (state is OrdersScreenSuccess) {
                if (state.orders.isEmpty) {
                  return SliverToBoxAdapter(
                    child: Center(child: Text('No Orders Found.')),
                  );
                } else {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final order = state.orders[index]; // OrderModel
                      for (var item in order.items!) {
                        print(item['name']); // أو أي مفتاح آخر
                      }

                      return OrderCard(
                        orderId: '${index + 1}',
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
                      child: Center(child: Text('No Orders Found.')),
                    ),
                  );
                } else {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final order = state.orders[index]; // OrderModel

                      return OrderCard(
                        orderId: '${index + 1}',
                        preparingTime: order.preparationTime!.isNotEmpty
                            ? SearchHelper.formatPreparedTime(
                                order.preparationTime!,
                              )
                            : 'Not Prepared Yet',
                        date: order.timestamp?.toString().split(' ')[0] ?? '',
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
    );
  }
}
