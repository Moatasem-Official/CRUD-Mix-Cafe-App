import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class CustomAnalysisChart extends StatefulWidget {
  const CustomAnalysisChart({super.key});

  @override
  State<CustomAnalysisChart> createState() => _CustomAnalysisChartState();
}

class _CustomAnalysisChartState extends State<CustomAnalysisChart> {
  bool showWeekly = true;
  int selectedYear = 2024;

  // Example sales data for each year (add more years as needed)
  final Map<int, List<FlSpot>> yearlySalesData = {
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

  // Weekly sales data (example)
  final List<FlSpot> weeklySales = [
    FlSpot(0, 1200),
    FlSpot(1, 1800),
    FlSpot(2, 1500),
    FlSpot(3, 2200),
    FlSpot(4, 2000),
    FlSpot(5, 3200),
    FlSpot(6, 2800),
  ];

  @override
  Widget build(BuildContext context) {
    final List<int> availableYears = yearlySalesData.keys.toList()..sort();

    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.brown.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    showWeekly
                        ? 'Weekly Sales Analytics'
                        : 'Yearly Sales Analytics ($selectedYear)',
                    style: TextStyle(
                      color: Color(0xFF4E342E),
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (!showWeekly)
                          DropdownButton<int>(
                            dropdownColor: Colors.brown.shade50,
                            borderRadius: BorderRadius.circular(8),
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.brown,
                            ),
                            iconSize: 32,
                            underline: const SizedBox(),
                            isExpanded: false,
                            focusColor: Colors.brown.shade50,
                            focusNode: FocusNode(),
                            alignment: Alignment.center,
                            value: selectedYear,
                            items: availableYears
                                .map(
                                  (year) => DropdownMenuItem(
                                    value: year,
                                    child: Text(year.toString()),
                                  ),
                                )
                                .toList(),
                            onChanged: (year) {
                              if (year != null) {
                                setState(() {
                                  selectedYear = year;
                                });
                              }
                            },
                            style: TextStyle(
                              color: Colors.brown.shade700,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ToggleButtons(
                          borderRadius: BorderRadius.circular(8),
                          selectedColor: Colors.white,
                          fillColor: Colors.brown,
                          color: Colors.brown.shade400,
                          constraints: const BoxConstraints(
                            minWidth: 60,
                            minHeight: 36,
                          ),
                          isSelected: [showWeekly, !showWeekly],
                          onPressed: (index) {
                            setState(() {
                              showWeekly = index == 0;
                            });
                          },
                          children: const [Text('Week'), Text('Year')],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                showWeekly
                    ? 'Track your restaurant\'s weekly sales performance'
                    : 'Track your restaurant\'s monthly sales for the year',
                style: TextStyle(color: Colors.brown.shade300, fontSize: 14),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              height: 240,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: LineChart(
                  LineChartData(
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
            ),
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.circle, size: 12, color: Color(0xFF795548)),
                  const SizedBox(width: 6),
                  Text(
                    'Sales (EGP)',
                    style: TextStyle(
                      color: Colors.brown.shade400,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
