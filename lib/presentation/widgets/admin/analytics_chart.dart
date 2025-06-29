import 'package:flutter/material.dart';
import 'package:mix_cafe_app/data/model/weekly_and_yearly_sales_data_model.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/custom_chart_content.dart';
import 'package:mix_cafe_app/presentation/widgets/admin/custom_chart_header_content.dart';

class CustomAnalysisChart extends StatefulWidget {
  const CustomAnalysisChart({super.key});

  @override
  State<CustomAnalysisChart> createState() => _CustomAnalysisChartState();
}

class _CustomAnalysisChartState extends State<CustomAnalysisChart> {
  bool showWeekly = true;
  int selectedYear = 2024;

  // Example sales data for each year (add more years as needed)
  final weeklyAndYearlySalesDataModel = WeeklyAndYearlySalesDataModel();

  @override
  Widget build(BuildContext context) {
    final List<int> availableYears =
        weeklyAndYearlySalesDataModel.yearlySales.keys.toList()..sort();

    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomChartHeaderContent(
              showWeekly: showWeekly,
              selectedYear: selectedYear,
              availableYears: availableYears,
              onYearChanged: (year) => setState(() => selectedYear = year),
              onShowWeeklyChanged: (value) =>
                  setState(() => showWeekly = value),
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
            CustomChartContent(
              showWeekly: showWeekly,
              weeklySales: weeklyAndYearlySalesDataModel.weeklySales,
              yearlySalesData: weeklyAndYearlySalesDataModel.yearlySales,
              selectedYear: selectedYear,
            ),
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.circle,
                    size: 12,
                    color: Color.fromARGB(255, 165, 101, 56),
                  ),
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
