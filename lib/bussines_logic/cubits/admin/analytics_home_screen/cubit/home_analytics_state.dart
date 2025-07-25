part of 'home_analytics_cubit.dart';

sealed class HomeAnalyticsState extends Equatable {
  const HomeAnalyticsState();

  @override
  List<Object> get props => [];
}

final class HomeAnalyticsInitial extends HomeAnalyticsState {}

final class HomeAnalyticsLoading extends HomeAnalyticsState {}

final class HomeAnalyticsSuccess extends HomeAnalyticsState {
  final List<dynamic> analyticsData;
  const HomeAnalyticsSuccess(this.analyticsData);
}

final class HomeAnalyticsError extends HomeAnalyticsState {
  final String message;
  const HomeAnalyticsError(this.message);
}

final class HomeAnalyticsNoInternet extends HomeAnalyticsState {}
