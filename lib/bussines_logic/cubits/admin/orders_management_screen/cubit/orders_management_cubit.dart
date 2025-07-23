import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mix_cafe_app/data/model/order_model.dart';
import 'package:mix_cafe_app/data/services/firestore/firestore_services.dart';

part 'orders_management_state.dart';

class OrdersManagementCubit extends Cubit<OrdersManagementState> {
  OrdersManagementCubit() : super(OrdersManagementLoading());

  List<OrderModel> _allOrders = [];

  Future<void> fetchOrders() async {
    emit(OrdersManagementLoading());
    try {
      _allOrders = await FirestoreServices().getAllCustomerOrders();
      emit(OrdersManagementLoaded(_allOrders));
    } catch (e) {
      emit(OrdersManagementError(e.toString()));
    }
  }

  void filterOrdersByStatus(String status) {
    emit(OrdersManagementLoading());
    final filteredOrders = _allOrders
        .where((order) => order.status?.toLowerCase() == status.toLowerCase())
        .toList();

    emit(OrdersManagementFilter(filteredOrders));
  }
}
