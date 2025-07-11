part of 'forget_password_cubit.dart';

sealed class ForgetPasswordState extends Equatable {
  const ForgetPasswordState();

  @override
  List<Object> get props => [];
}

final class ForgetPasswordInitial extends ForgetPasswordState {}

final class ForgetPasswordLoading extends ForgetPasswordState {}

final class ForgetPasswordSuccess extends ForgetPasswordState {
  final String message;
  const ForgetPasswordSuccess(this.message);
}

final class ForgetPasswordError extends ForgetPasswordState {
  final String error;
  const ForgetPasswordError(this.error);

  @override
  List<Object> get props => [error];
}

final class ForgetPasswordNoInternet extends ForgetPasswordState {
  final String message;
  const ForgetPasswordNoInternet(this.message);

  @override
  List<Object> get props => [message];
}

final class ForgetPasswordEmpty extends ForgetPasswordState {
  final String message;
  const ForgetPasswordEmpty(this.message);

  @override
  List<Object> get props => [message];
}

final class ForgetPasswordInvalidEmail extends ForgetPasswordState {
  final String message;
  const ForgetPasswordInvalidEmail(this.message);

  @override
  List<Object> get props => [message];
}
