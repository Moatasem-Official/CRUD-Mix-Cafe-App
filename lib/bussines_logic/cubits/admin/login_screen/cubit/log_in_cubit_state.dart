part of 'log_in_cubit_cubit.dart';

sealed class LogInCubitState extends Equatable {
  const LogInCubitState();

  @override
  List<Object> get props => [];
}

final class LogInCubitInitial extends LogInCubitState {
  const LogInCubitInitial();
}

final class LogInCubitLoading extends LogInCubitState {}

final class LogInCubitSuccess extends LogInCubitState {
  final String message;
  const LogInCubitSuccess(this.message);
}

final class LogInCubitError extends LogInCubitState {
  final String error;
  const LogInCubitError(this.error);
}

final class LogInCubitNoInternet extends LogInCubitState {
  final String message;
  const LogInCubitNoInternet(this.message);
}

final class LogInCubitWrongEmailOrPassword extends LogInCubitState {
  final String message;
  const LogInCubitWrongEmailOrPassword(this.message);
}

final class LogInCubitWrongEmailAndPassword extends LogInCubitState {
  final String message;
  const LogInCubitWrongEmailAndPassword(this.message);
}
