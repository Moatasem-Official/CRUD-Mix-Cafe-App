import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../bussines_logic/cubits/admin/analytics_home_screen/chart_cubit/cubit/chart_distributions_analysis_cubit.dart';
import 'custom_chart_content.dart';
import 'custom_chart_header_content.dart';

class CustomAnalysisChart extends StatefulWidget {
  const CustomAnalysisChart({super.key});

  @override
  State<CustomAnalysisChart> createState() => _CustomAnalysisChartState();
}

class _CustomAnalysisChartState extends State<CustomAnalysisChart> {
  bool showWeekly = true;
  int selectedYear = 2024;

  @override
  Widget build(BuildContext context) {
    final List<int> availableYears = List.generate(
      10,
      (index) => DateTime.now().year - index,
    );
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
                    : 'Track monthly sales in $selectedYear',
                style: TextStyle(color: Colors.brown.shade300, fontSize: 14),
              ),
            ),
            const SizedBox(height: 30),
            BlocBuilder<
              ChartDistributionsAnalysisCubit,
              ChartDistributionsAnalysisState
            >(
              builder: (context, state) {
                if (state is ChartDistributionsAnalysisLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Color.fromARGB(255, 165, 101, 56),
                    ),
                  );
                } else if (state
                    is ChartDistributionsAnalysisDistributionSuccess) {
                  return CustomChartContent(
                    showWeekly: showWeekly,
                    selectedYear: selectedYear,
                    weeklySales: state.weeklySpots,
                    yearlySalesData: state.yearlySpots,
                  );
                } else if (state is ChartDistributionsAnalysisError) {
                  return Center(child: Text(state.message));
                } else {
                  // fallback safety
                  return const SizedBox(); // don't show "Unknown state" to users
                }
              },
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
                    semanticLabel: 'Sales Line',
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
