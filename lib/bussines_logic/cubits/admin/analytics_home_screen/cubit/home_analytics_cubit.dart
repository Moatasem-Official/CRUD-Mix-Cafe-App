import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../../../data/services/firestore/firestore_services.dart';

part 'home_analytics_state.dart';

class HomeAnalyticsCubit extends Cubit<HomeAnalyticsState> {
  HomeAnalyticsCubit() : super(HomeAnalyticsInitial());
  FirestoreServices firestoreServices = FirestoreServices();

  void getAnalytics() async {
    emit(HomeAnalyticsLoading());
    try {
      final ordersCount = await firestoreServices.getOrdersCount();
      final customersCount = await firestoreServices.getAllCustomersCount();
      final allSales = await firestoreServices.calculateTotalRevenue();
      emit(HomeAnalyticsSuccess([ordersCount, allSales, customersCount]));
    } catch (e) {
      emit(HomeAnalyticsError(e.toString()));
    }
  }
}
