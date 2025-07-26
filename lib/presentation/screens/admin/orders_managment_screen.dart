import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mix_cafe_app/bussines_logic/cubits/admin/orders_management_screen/cubit/orders_management_cubit.dart';
import '../../widgets/admin/Orders_Screen_Widgets/custom_order_container.dart';
import '../../widgets/admin/Orders_Screen_Widgets/custom_orders_screen_appbar.dart';

class OrdersManagmentScreen extends StatefulWidget {
  const OrdersManagmentScreen({super.key});

  @override
  State<OrdersManagmentScreen> createState() => _OrdersManagmentScreenState();
}

class _OrdersManagmentScreenState extends State<OrdersManagmentScreen> {
  @override
  initState() {
    context.read<OrdersManagementCubit>().fetchOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomOrdersManagmentAppBar(
        onTabSelected: (tabText) {
          tabText == 'All'
              ? context.read<OrdersManagementCubit>().fetchOrders()
              : tabText == 'Pending'
              ? context.read<OrdersManagementCubit>().filterOrdersByStatus(
                  'pending',
                )
              : tabText == 'Delivered'
              ? context.read<OrdersManagementCubit>().filterOrdersByStatus(
                  'delivered',
                )
              : context.read<OrdersManagementCubit>().filterOrdersByStatus(
                  'cancelled',
                );
        },
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: RefreshIndicator(
          color: const Color(0xFFA0522D),
          backgroundColor: Colors.white,
          strokeWidth: 2.0,
          displacement: 20.0,
          triggerMode: RefreshIndicatorTriggerMode.anywhere,
          notificationPredicate: (_) => true,
          onRefresh: () async =>
              context.read<OrdersManagementCubit>().fetchOrders(),
          child: Column(
            children: [
              const SizedBox(height: 10),
              BlocBuilder<OrdersManagementCubit, OrdersManagementState>(
                builder: (context, state) {
                  if (state is OrdersManagementLoading) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height - 200,
                      child: const Center(child: CircularProgressIndicator()),
                    );
                  } else if (state is OrdersManagementLoaded) {
                    if (state.orders.isEmpty) {
                      return const Center(child: Text('لا توجد طلبات حالياً.'));
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.orders.length,
                      itemBuilder: (context, index) {
                        final order = state.orders[index];
                        final id = (index + 1).toString();
                        return AuroraOrderCard(
                          orderId: id,
                          customerName: order.customerName ?? 'غير معروف',
                          image: order.customerImage!,
                          date: formatDate(order.timestamp),
                          time: formatTime(order.timestamp),
                          status: order.status ?? '---',
                          onPressed: () => Navigator.of(context).pushNamed(
                            '/adminOrderDetailsScreen',
                            arguments: {
                              'order': order,
                              'id': id,
                            }, // يمكن تمرير الطلب كامل إذا احتجت التفاصيل
                          ),
                        );
                      },
                    );
                  } else if (state is OrdersManagementError) {
                    return const Center(
                      child: Text('حدث خطأ أثناء تحميل الطلبات.'),
                    );
                  } else if (state is OrdersManagementFilter) {
                    if (state.orders.isEmpty) {
                      return const Center(child: Text('لا توجد طلبات حالياً.'));
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.orders.length,
                      itemBuilder: (context, index) {
                        final order = state.orders[index];
                        final id = (index + 1).toString();
                        return AuroraOrderCard(
                          orderId: id,
                          customerName: order.customerName ?? 'غير معروف',
                          image: order.customerImage!,
                          date: formatDate(order.timestamp),
                          time: formatTime(order.timestamp),
                          status: order.status ?? '---',
                          onPressed: () => Navigator.of(context).pushNamed(
                            '/adminOrderDetailsScreen',
                            arguments: {
                              'order': order,
                              'id': id,
                            }, // يمكن تمرير الطلب كامل إذا احتجت التفاصيل
                          ),
                        );
                      },
                    );
                  } else {
                    return const SizedBox(); // fallback في حالة غير متوقعة
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String formatDate(DateTime? timestamp) {
  if (timestamp == null) return '---';
  return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
}

String formatTime(DateTime? timestamp) {
  if (timestamp == null) return '---';
  return '${timestamp.hour}:${timestamp.minute.toString().padLeft(2, '0')}';
}
