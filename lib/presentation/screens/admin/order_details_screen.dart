import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:mix_cafe_app/data/helpers/custom_snack_bar.dart';
import 'package:mix_cafe_app/data/helpers/when_loading_widget.dart';
import '../../../data/helpers/search_helper.dart';
import '../../../bussines_logic/cubits/admin/order_details_screen/cubit/order_details_screen_cubit.dart';
import '../../../data/model/order_model.dart';
import '../../widgets/admin/Order_details_screen/Build_Action_Panel/action_panel_main_widget.dart';
import '../../widgets/admin/Order_details_screen/custom_info_panel.dart';
import '../../widgets/admin/Order_details_screen/custom_product_panel.dart';
import '../../widgets/admin/Order_details_screen/custom_row_info.dart';
import '../../widgets/admin/Order_details_screen/custom_sliver_app_bar.dart';
import '../../widgets/admin/Order_details_screen/helper_functions.dart';

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
  bool isLoading = false;

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
    return BlocListener<OrderDetailsScreenCubit, OrderDetailsScreenState>(
      listener: (context, state) {
        if (state is DeleteOrderLoading) {
          setState(() {
            isLoading = true;
          });
        } else if (state is DeleteOrderSuccess) {
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
        } else if (state is DeleteOrderError) {
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
        } else if (state is UpdateOrderStatusLoading) {
          setState(() {
            isLoading = true;
          });
        } else if (state is UpdateOrderStatusSuccess) {
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
        } else if (state is UpdateOrderStatusError) {
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
        } else if (state is UpdateOrderPreparationTimeLoading) {
          setState(() {
            isLoading = true;
          });
        } else if (state is UpdateOrderPreparationTimeSuccess) {
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
        } else if (state is UpdateOrderPreparationTimeError) {
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
      child: Stack(
        children: [
          Scaffold(
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
                        orderPreparedTime:
                            widget.order.preparationTime!.isNotEmpty
                            ? SearchHelper.formatPreparedTime(
                                widget.order.preparationTime!,
                              )
                            : _estimatedDuration != null
                            ? HelperFunctions.formatDuration(
                                _estimatedDuration!,
                              )
                            : 'Set Time',
                        currentStatus: _currentStatus,
                        statusOptions: _statusOptions,
                        estimatedDuration: _estimatedDuration,
                        onStatusChanged: (newStatus) => setState(() {
                          _currentStatus = newStatus!;
                        }),
                        onConfirm: () {
                          if (_estimatedDuration != null &&
                              _currentStatus.isNotEmpty) {
                            context
                                .read<OrderDetailsScreenCubit>()
                                .updateOrderPreparationTime(
                                  widget.order.orderId!,
                                  widget.order.userId!,
                                  _estimatedDuration!,
                                );
                            context
                                .read<OrderDetailsScreenCubit>()
                                .updateOrderStatus(
                                  widget.order.orderId!,
                                  widget.order.userId!,
                                  _currentStatus == 'Pending'
                                      ? 'pending'
                                      : _currentStatus == 'Delivered'
                                      ? 'delivered'
                                      : 'cancelled',
                                );
                          } else if (_estimatedDuration != null &&
                              _currentStatus.isEmpty) {
                            context
                                .read<OrderDetailsScreenCubit>()
                                .updateOrderPreparationTime(
                                  widget.order.orderId!,
                                  widget.order.userId!,
                                  _estimatedDuration!,
                                );
                          } else if (_estimatedDuration == null &&
                              _currentStatus.isNotEmpty) {
                            context
                                .read<OrderDetailsScreenCubit>()
                                .updateOrderStatus(
                                  widget.order.orderId!,
                                  widget.order.userId!,
                                  _currentStatus == 'Pending'
                                      ? 'pending'
                                      : _currentStatus == 'Delivered'
                                      ? 'delivered'
                                      : 'cancelled',
                                );
                          } else if (_estimatedDuration == null &&
                              _currentStatus.isEmpty) {
                            print('No changes were made.');
                          } else {
                            print(
                              'Unexpected combination of estimated delivery time and order status.',
                            );
                          }
                        },
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
          ),
          isLoading ? const WhenLoadingLogInWidget() : Container(),
        ],
      ),
    );
  }
}
