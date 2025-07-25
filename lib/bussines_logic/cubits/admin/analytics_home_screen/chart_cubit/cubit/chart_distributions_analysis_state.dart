part of 'chart_distributions_analysis_cubit.dart';

sealed class ChartDistributionsAnalysisState extends Equatable {
  const ChartDistributionsAnalysisState();

  @override
  List<Object> get props => [];
}

final class ChartDistributionsAnalysisInitial
    extends ChartDistributionsAnalysisState {}

final class ChartDistributionsAnalysisLoading
    extends ChartDistributionsAnalysisState {}

final class ChartDistributionsAnalysisDistributionSuccess
    extends ChartDistributionsAnalysisState {
  final List<FlSpot> weeklySpots;
  final Map<int, List<FlSpot>> yearlySpots;
  const ChartDistributionsAnalysisDistributionSuccess(
    this.weeklySpots,
    this.yearlySpots,
  );
}

final class ChartDistributionsAnalysisError
    extends ChartDistributionsAnalysisState {
  final String message;
  const ChartDistributionsAnalysisError(this.message);
}
