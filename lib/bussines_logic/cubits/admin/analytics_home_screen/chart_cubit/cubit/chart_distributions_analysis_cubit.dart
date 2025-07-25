import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:mix_cafe_app/data/model/weekly_and_yearly_sales_data_model.dart';
import 'package:mix_cafe_app/data/services/firestore/firestore_services.dart';

part 'chart_distributions_analysis_state.dart';

class ChartDistributionsAnalysisCubit
    extends Cubit<ChartDistributionsAnalysisState> {
  ChartDistributionsAnalysisCubit()
    : super(ChartDistributionsAnalysisInitial());

  FirestoreServices firestoreServices = FirestoreServices();

  void getAnalyticsDistribution() async {
    emit(ChartDistributionsAnalysisLoading());
    try {
      final weeklyData = await firestoreServices.getRevenueDistribution(
        'weekly',
      );
      print(weeklyData);
      final weeklySpots = WeeklyAndYearlySalesDataModel.generateWeeklySpots(
        weeklyData,
      );

      print(weeklySpots);

      final yearlyData = await firestoreServices.getRevenueDistribution(
        'yearly',
      );
      // check if it's List<double>
      final int currentYear = DateTime.now().year;
      final yearlySpots =
          WeeklyAndYearlySalesDataModel.generateYearlySpotsFromList(
            currentYear,
            yearlyData,
          );
      emit(
        ChartDistributionsAnalysisDistributionSuccess(weeklySpots, yearlySpots),
      );
    } catch (e) {
      emit(ChartDistributionsAnalysisError(e.toString()));
    }
  }
}
