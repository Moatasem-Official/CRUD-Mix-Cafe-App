import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CustomChartContent extends StatelessWidget {
  const CustomChartContent({
    super.key,
    required this.showWeekly,
    required this.weeklySales,
    required this.yearlySalesData,
    required this.selectedYear,
  });

  final bool showWeekly;
  final List<FlSpot> weeklySales;
  final Map<int, List<FlSpot>> yearlySalesData;
  final int selectedYear;

  @override
  Widget build(BuildContext context) {
    // --- الجزء ده هو اللي هيتعدل ---

    // 1. بنحدد البيانات اللي هنستخدمها بناءً على الحالة (أسبوعي أم سنوي)
    final List<FlSpot> spots = showWeekly
        ? weeklySales
        : (yearlySalesData[selectedYear] ?? []);

    // 2. بنعمل رسالة مخصصة في حالة عدم وجود بيانات
    final Widget noDataWidget = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.insights_outlined, color: Colors.brown.shade300, size: 40),
          const SizedBox(height: 8),
          Text(
            showWeekly
                ? 'No sales data for this week yet.'
                : 'No data available for $selectedYear',
            style: TextStyle(
              color: Colors.brown.shade400,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );

    final hasActualData = spots.any((spot) => spot.y > 0);
    return SizedBox(
      height: 260,
      child: hasActualData
          ? Padding(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 16.0),
              child: LineChart(
                LineChartData(
                  lineTouchData: LineTouchData(
                    touchTooltipData: LineTouchTooltipData(
                      getTooltipColor: (touchedSpot) =>
                          Color.fromARGB(255, 165, 101, 56), // لون المربع
                      getTooltipItems: (touchedSpots) {
                        return touchedSpots.map((spot) {
                          return LineTooltipItem(
                            '${spot.y.toStringAsFixed(0)} \$',
                            const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }).toList();
                      },
                    ),
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: true,
                    horizontalInterval: showWeekly ? 500 : 5000,
                    getDrawingHorizontalLine: (value) => FlLine(
                      color: Colors.brown.withOpacity(0.1),
                      strokeWidth: 1,
                    ),
                    getDrawingVerticalLine: (value) => FlLine(
                      color: Colors.brown.withOpacity(0.08),
                      strokeWidth: 1,
                    ),
                  ),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: showWeekly ? 500 : 5000,
                        getTitlesWidget: (value, meta) => Padding(
                          padding: const EdgeInsetsDirectional.only(end: 4.0),
                          child: Transform.translate(
                            offset: const Offset(-10, 0),
                            child: Text(
                              formatLargeNumber(value.toString()),
                              style: TextStyle(
                                color: Colors.brown.shade400,
                                fontWeight: FontWeight.w500,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ),
                        reservedSize: 36,
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 1,
                        getTitlesWidget: (value, meta) {
                          if (showWeekly) {
                            const days = [
                              'Sat',
                              'Sun',
                              'Mon',
                              'Tue',
                              'Wed',
                              'Thu',
                              'Fri',
                            ];
                            return Padding(
                              padding: const EdgeInsetsDirectional.only(
                                top: 8.0,
                              ),
                              child: Text(
                                days[value.toInt() % days.length],
                                style: TextStyle(
                                  color: Colors.brown.shade400,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                ),
                              ),
                            );
                          } else {
                            const months = [
                              'Jan',
                              'Feb',
                              'Mar',
                              'Apr',
                              'May',
                              'Jun',
                              'Jul',
                              'Aug',
                              'Sep',
                              'Oct',
                              'Nov',
                              'Dec',
                            ];
                            return Padding(
                              padding: const EdgeInsetsDirectional.only(
                                top: 8.0,
                              ),
                              child: Text(
                                months[value.toInt() % months.length],
                                style: TextStyle(
                                  color: Colors.brown.shade400,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(
                      color: Colors.brown.withOpacity(0.15),
                      width: 1,
                    ),
                  ),
                  minX: 0,
                  maxX: showWeekly ? 6 : 11,
                  minY: 0,
                  maxY: calculateMaxY(),
                  lineBarsData: [
                    LineChartBarData(
                      spots: showWeekly
                          ? weeklySales
                          : (yearlySalesData[selectedYear] ?? []),
                      isCurved: true,
                      color: const Color.fromARGB(255, 165, 101, 56),
                      barWidth: 4,
                      belowBarData: BarAreaData(
                        show: true,
                        color: const Color(0xFFBCAAA4).withOpacity(0.22),
                      ),
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, bar, index) =>
                            FlDotCirclePainter(
                              radius: 5,
                              color: Colors.white,
                              strokeWidth: 1,
                              strokeColor: const Color.fromARGB(
                                255,
                                165,
                                101,
                                56,
                              ),
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : noDataWidget,
    );
  }

  String formatLargeNumber(String numberString) {
    try {
      double number = double.parse(numberString.replaceAll(' \$', ''));
      if (number >= 1000000) {
        return '${(number / 1000000).toStringAsFixed(1)}M';
      } else if (number >= 1000) {
        return '${(number / 1000).toStringAsFixed(1)}k';
      } else {
        return number.toStringAsFixed(0);
      }
    } catch (e) {
      return numberString; // Return original string if parsing fails
    }
  }

  double calculateMaxY() {
    final spots = showWeekly
        ? weeklySales
        : (yearlySalesData[selectedYear] ?? []);

    final maxY = spots
        .map((e) => e.y)
        .fold<double>(0.0, (prev, next) => next > prev ? next : prev);
    return (maxY * 1.2).ceilToDouble(); // زيادة 20% احتياطية
  }
}
