import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:mix_cafe_app/bussines_logic/cubits/admin/order_details_screen/cubit/order_details_screen_cubit.dart';
import 'package:mix_cafe_app/bussines_logic/cubits/admin/orders_management_screen/cubit/orders_management_cubit.dart';
import 'package:mix_cafe_app/data/model/order_model.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/Order_details_screen/Build_Action_Panel/action_panel_main_widget.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/Order_details_screen/custom_info_panel.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/Order_details_screen/custom_product_panel.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/Order_details_screen/custom_row_info.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/Order_details_screen/custom_sliver_app_bar.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/Order_details_screen/helper_functions.dart';

class AdminOrderDetailsScreen extends StatefulWidget {
  const AdminOrderDetailsScreen({
    super.key,
    required this.order,
    required this.orderId,
  });

  final OrderModel order;
  final String orderId;

  @override
  State<AdminOrderDetailsScreen> createState() =>
      _AdminOrderDetailsScreenState();
}

class _AdminOrderDetailsScreenState extends State<AdminOrderDetailsScreen> {
  late String _currentStatus;
  final List<String> _statusOptions = ['Pending', 'Delivered', 'Cancelled'];
  Duration? _estimatedDuration;

  @override
  void initState() {
    super.initState();
    final initialStatus = widget.order.status?.toLowerCase() ?? 'pending';
    _currentStatus = _statusOptions.firstWhere(
      (option) => option.toLowerCase() == initialStatus,
      orElse: () => _statusOptions.first,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      body: CustomScrollView(
        slivers: [
          CustomSliverAppBar(
            orderId: widget.orderId,
            currentStatus: _currentStatus,
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                CustomInfoPanel(
                  icon: IconlyBold.document,
                  title: 'Order Information',
                  children: [
                    CustomRowInfo(
                      label: 'Order Date',
                      value: HelperFunctions.formatDate(
                        widget.order.timestamp,
                      ),
                    ),
                    CustomRowInfo(
                      label: 'Order Time',
                      value: HelperFunctions.formatTime(
                        widget.order.timestamp,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                CustomInfoPanel(
                  icon: IconlyBold.profile,
                  title: 'Customer Details',
                  children: [
                    CustomRowInfo(
                      label: 'Name',
                      value: widget.order.customerName!,
                    ),
                    CustomRowInfo(
                      label: 'Phone',
                      value: widget.order.customerPhone!.isEmpty
                          ? 'N/A'
                          : widget.order.customerPhone!,
                    ),
                    CustomRowInfo(
                      label: 'Address',
                      value: widget.order.customerAddress!.isEmpty
                          ? 'N/A'
                          : widget.order.customerAddress!,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                CustomProductPanel(order: widget.order),
                const SizedBox(height: 16),
                ActionPanelMainWidget(
                  currentStatus: _currentStatus,
                  statusOptions: _statusOptions,
                  estimatedDuration: _estimatedDuration,
                  onStatusChanged: (newStatus) => setState(() {
                    _currentStatus = newStatus!;
                  }),
                  onConfirm: () {},
                  onDelete: () =>
                      HelperFunctions.showDeleteConfirmationDialog(
                        context,
                        widget.order.userId!,
                        () {
                          final userId = widget.order.userId;
                          final orderId = widget.order.orderId;
      
                          if (userId != null && orderId != null) {
                            context
                                .read<OrderDetailsScreenCubit>()
                                .deleteOrder(orderId, userId);
                          } else {
                            print('userId or orderId is null');
                          }
                          Navigator.pop(context);
                        },
                      ),
                  onTap: () => HelperFunctions.selectTime(context, (p0) {
                    setState(() {
                      _estimatedDuration = Duration(
                        hours: p0.hour,
                        minutes: p0.minute,
                      );
                    });
                  }),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
