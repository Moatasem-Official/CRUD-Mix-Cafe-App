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
    return SizedBox(
      height: 240,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: LineChart(
          LineChartData(
            gridData: FlGridData(
              show: true,
              drawVerticalLine: true,
              horizontalInterval: showWeekly ? 500 : 5000,
              getDrawingHorizontalLine: (value) =>
                  FlLine(color: Colors.brown.withOpacity(0.1), strokeWidth: 1),
              getDrawingVerticalLine: (value) =>
                  FlLine(color: Colors.brown.withOpacity(0.08), strokeWidth: 1),
            ),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: showWeekly ? 500 : 5000,
                  getTitlesWidget: (value, meta) => Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      value.toInt().toString(),
                      style: TextStyle(
                        color: Colors.brown.shade400,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
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
                        padding: const EdgeInsets.only(top: 8.0),
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
                        padding: const EdgeInsets.only(top: 8.0),
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
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
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
            maxY: showWeekly ? 3500 : 40000,
            lineBarsData: [
              LineChartBarData(
                spots: showWeekly
                    ? weeklySales
                    : (yearlySalesData[selectedYear] ?? []),
                isCurved: true,
                color: const Color(0xFF795548),
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
                        strokeWidth: 3,
                        strokeColor: const Color(0xFF795548),
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
