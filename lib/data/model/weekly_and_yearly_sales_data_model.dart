import 'package:fl_chart/fl_chart.dart';

class WeeklyAndYearlySalesDataModel {
  final List<FlSpot> weeklySales = [
    FlSpot(0, 1200),
    FlSpot(1, 1800),
    FlSpot(2, 1500),
    FlSpot(3, 2200),
    FlSpot(4, 2000),
    FlSpot(5, 3200),
    FlSpot(6, 2800),
  ];
  final Map<int, List<FlSpot>> yearlySales = {
    2023: [
      FlSpot(0, 18000),
      FlSpot(1, 19500),
      FlSpot(2, 21000),
      FlSpot(3, 22000),
      FlSpot(4, 25000),
      FlSpot(5, 27000),
      FlSpot(6, 29000),
      FlSpot(7, 31000),
      FlSpot(8, 32000),
      FlSpot(9, 34000),
      FlSpot(10, 35500),
      FlSpot(11, 37000),
    ],
    2024: [
      FlSpot(0, 21000),
      FlSpot(1, 18500),
      FlSpot(2, 23000),
      FlSpot(3, 25000),
      FlSpot(4, 27000),
      FlSpot(5, 30000),
      FlSpot(6, 32000),
      FlSpot(7, 31000),
      FlSpot(8, 29500),
      FlSpot(9, 34000),
      FlSpot(10, 36000),
      FlSpot(11, 39000),
    ],
  };
}
