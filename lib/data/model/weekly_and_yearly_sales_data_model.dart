import 'package:fl_chart/fl_chart.dart';

class WeeklyAndYearlySalesDataModel {
  /// يحوّل قائمة مبيعات أسبوعية إلى List<FlSpot>
  static List<FlSpot> generateWeeklySpots(List<double> data) {
    return List.generate(
      data.length,
      (index) => FlSpot(index.toDouble(), data[index] < 0 ? 0 : data[index]),
    );
  }

  /// يحوّل قائمة مبيعات سنوية إلى List<FlSpot> (مثلاً 12 شهر)
  static Map<int, List<FlSpot>> generateYearlySpotsFromList(
    int year,
    List<double> data,
  ) {
    final List<FlSpot> spots = List.generate(
      data.length,
      (index) => FlSpot(index.toDouble(), data[index] < 0 ? 0 : data[index]),
    );
    return {year: spots};
  }
}
